
terraform {
  backend "s3" {
    bucket         = "${terraform.workspace}-tf-bucketzhzast21" # change this
    key            = "state/${terraform.workspace}/terraform.tfstate"
    region         = "us-east-2"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}
