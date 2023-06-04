variable "aws_region" {
  description = "aws region to deploy"
  type        = string
  default     = "us-east-1"
}

variable "aws_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "image_id" {
  type    = string
  default = "ami-0715c1897453cabd1" // AWS Linux 2023
}

variable "minimum_instance" {
  type    = string
  default = "1"
}

variable "desired_instance" {
  type    = string
  default = "1"
}

variable "maximum_instance" {
  type    = string
  default = "1"
}

variable "pem_key" {
  type    = string
  default = "upworks"
}