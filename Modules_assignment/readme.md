Modules need to be referred from 

https://github.com/hhgsharish/terraform_modules/tree/main
-------------------------------------------------------
Modules & workspace assignment 

Create a Terraform module that provisions a VPC, security groups (allowing SSH & HTTP) , and an EC2 instance . Upload the module code to your github repo and reference the github source for your module block 
The setup should use Terraform workspaces for different environments (dev, stage, prod) and allow users to specify the CIDR block of their choice.

Make use of - 
Variables for user-defined inputs.
Locals for computed values.
Functions to format values dynamically.
