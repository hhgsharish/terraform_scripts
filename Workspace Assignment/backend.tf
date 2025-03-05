
terraform {
  backend "s3" {
    bucket         = "my-tf-test-bucketzzz" # change this
    key            = "state/${terraform.workspace}/terraform.tfstate"
    region         = "us-east-2"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}