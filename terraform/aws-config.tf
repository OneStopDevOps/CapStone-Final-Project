# Defining an AWS provider for Terraform
####################################################

terraform {
  required_providers {
    aws = {
	    source  = "hashicorp/aws"
	    version = "~> 3.26"
  	}
  }
}

# Terraform provider
provider "aws" {
  profile = "default"
  region  = var.aws_region
}
