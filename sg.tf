resource "aws_security_group" "sg" {
  name        = "SG-Dev"
  description = "Security group allowing SSH, HTTP, and custom ports"

  #ingress {
  #  from_port   = 22
  #  to_port     = 22
  #  protocol    = "-1"
  #  cidr_blocks = ["0.0.0.0/0"] //Replace this with your own IP if you don't want public access from the Internet
  #}

  # Replicate this ingress if you wish to add more ports and restrict them by IP in the cidr_blocks field
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "Dev"
    Terraform   = "true"
    Environment = "Dev"
  }

}