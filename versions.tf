# Terraform Block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Provider Block
provider "aws" {
  region  = var.aws_region
  profile = "sre-admin"
}

# Create Random Pet Resource
resource "random_pet" "this" {
  length = 2
}
