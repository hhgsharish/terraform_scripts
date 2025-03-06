variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for EC2"
  type        = string
}

variable "instance_types" {
  description = "Instance type based on the workspace"
  type        = map(string)

  default = {
    dev    = "t2.micro"
    stage  = "t3.small"
    prod   = "t3.medium"
  }
}
