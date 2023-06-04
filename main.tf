provider "aws" {
  region = var.aws_region
}

resource "aws_launch_configuration" "launch_config" {
  name_prefix     = "Dev-ASG-Config"
  image_id        = var.image_id
  instance_type   = var.aws_instance_type
  key_name        = var.pem_key
  security_groups = [aws_security_group.sg.id]

}

resource "aws_autoscaling_group" "asg" {
  availability_zones   = ["us-east-1a"]
  name                 = "Dev-ASG"
  min_size             = var.minimum_instance
  max_size             = var.maximum_instance
  desired_capacity     = var.desired_instance
  launch_configuration = aws_launch_configuration.launch_config.name
  force_delete         = true

  tag {
    key                 = "Environment"
    value               = "Dev"
    propagate_at_launch = true
  }

  tag {
    key                 = "Terraform"
    value               = "True"
    propagate_at_launch = true
  }

}



resource "aws_instance" "ec2_instance" {
  count                  = aws_autoscaling_group.asg.desired_capacity
  ami                    = var.image_id
  instance_type          = var.aws_instance_type
  key_name               = var.pem_key
  vpc_security_group_ids = [aws_security_group.sg.id]
  monitoring             = true

provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ec2-user"  # or the appropriate SSH user for your AMI
      private_key = file("upworks.pem")
      host        = self.public_ip
    }

    inline = [
      "sudo yum update -y",
      "sudo yum upgrade -y"
    ]
  }
}

resource "aws_autoscaling_policy" "asg_policy" {
  name                   = "Dev-ASG-Policy"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.asg.name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 100.0
  }
}


