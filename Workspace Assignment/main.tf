provider "aws" {
  #Access key and secret key are not needed
  #refers from the environment variables
  region = "us-east-2" // var.aws_region
}

locals {
  workspace      = terraform.workspace
  bucket_name    = "${local.workspace}-tf-bucketzhzast21"
  instance_types = var.instance_type

  common_tags = {
    Environment = local.workspace
    ManagedBy   = "Terraform"
  }
}

resource "aws_instance" "Assignment" {
  instance_type = lookup(var.instance_type,terraform.workspace,"t2.micro")
  ami = var.ami_value

    tags = merge(local.common_tags, {
    Name = "${local.workspace}-EC2"

})
}

 resource "aws_s3_bucket" "s3-bucket" {
    bucket = local.bucket_name
    tags = merge(local.common_tags, {
    Name = local.bucket_name
  })
}
# Create a DynamoDB table for state locking
resource "aws_dynamodb_table" "terraform_lock" {
  name           = "terraform-lock-${terraform.workspace}"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

# Output values for debugging
output "s3_bucket_name" {
  value = aws_s3_bucket.s3-bucket.id
}

output "ec2_instance_type" {
  value = aws_instance.Assignment.instance_type
}