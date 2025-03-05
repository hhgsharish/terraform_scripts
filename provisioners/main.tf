provider "aws" {
  #Access key and secret key are not needed
  #refers from the environment variables
  region = "us-east-2" // var.aws_region
}

resource "aws_key_pair" "example" {
  key_name = "harish-key"
  public_key = file("id_rsa.pub")
}

variable "cidr" {
  default = "10.0.0.0/16"
}

resource "aws_vpc" "my-vpc" {
  cidr_block = var.cidr
}

resource "aws_subnet" "my-subnet" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my-vpc.id
}

resource "aws_route_table" "my-rt" {
  vpc_id =  aws_vpc.my-vpc.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rta1" {
  subnet_id = aws_subnet.my-subnet.id
  route_table_id = aws_route_table.my-rt.id
}

resource "aws_security_group" "aws-sg" {
  name = "sec-gp"
  vpc_id = aws_vpc.my-vpc.id
 
 ingress {
  description = "HTTP from VPC"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

 }
 ingress {
  description = "SSH"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  
 }
 
 egress {
  //description = "HTTP from VPC"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  
 }

 tags = {
  name = "Web-sg"
 }
  }  



resource "aws_instance" "Example" {
  instance_type = "t2.micro"
  ami = "ami-0cb91c7de36eed2cb"
  key_name = aws_key_pair.example.key_name
  vpc_security_group_ids = [aws_security_group.aws-sg.id]
  subnet_id = aws_subnet.my-subnet.id

  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file("~/.ssh/id_rsa")
    host = self.public_ip
  }

  provisioner "file" {
    source = "app.py"
    destination = "/home/ubuntu/app.py"
  }

  provisioner "remote-exec" {
    inline = [ 
      "echo 'Hello from Remote instance:'",
      "sudo apt update -y",
      "sudo apt upgrade -y",
      "sudo apt install -y python3",
      "sudo apt install -y python3-pip3",
      "cd /home/ubuntu",
      "sudo pip3 install flask",
      "sudo python3 app.py & nohup", ]
     
  }
}
