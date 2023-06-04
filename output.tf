output "public_ips" {
  value = aws_instance.ec2_instance[*].public_ip
}