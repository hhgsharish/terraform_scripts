

provider "aws" {
  region = var.aws_region //"us-east-2"
}

module "vpc" {
  source        = "github.com/hhgsharish/terraform_modules/ec2_vpc" # Change to your GitHub repo
  vpc_cidr      = var.vpc_cidr
  ami_id        = var.ami_id
  instance_type = lookup(var.instance_types, terraform.workspace, "t2.micro")
}
