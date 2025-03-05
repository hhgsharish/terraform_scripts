variable "ami_value"{
    description = "ami value"
    type = string
}

variable "instance_type" {
    description = "instace type"
    type = map(string)

    default = {
      "default" = "t2.micro"   
      "dev"     = "t2.medium"
      "stage" = "t2.micro"   
      "prod"    = "t2.large"
    }
  
}