provider "aws" {
  region = "us-east-2"
}


module "ec2_instance" {
  source = "./modules/ec2_instance"
  ami_value = "ami-0cb91c7de36eed2cb"
  instance_type = "t2.micro"

}
