Workspace Assignment - 

You are managing infrastructure for multiple environments (dev, staging, and prod) using Terraform workspaces.
Your goal is to create an S3 bucket and an EC2 instance, where:

	The S3 bucket name should be prefixed with the workspace name.
	The EC2 instance type should vary based on the workspace (t2.micro for dev, t3.small for staging, and t3.medium for prod).
Store Terraform state in an S3 backend with state locking enabled using a DynamoDB table.
Use variables for flexibility, locals for calculated values, and functions to dynamically construct names.

terraform workspace new prod
terraform workspace new stage
terraform workspace new dev

To Select:
Terraform workspace select <workspace name>
Terraform workspace select prod

To List:
Terraform workspace list
