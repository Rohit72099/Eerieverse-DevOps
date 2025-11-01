# AWS Provider configuration
provider "aws" {
  region = "ap-south-1"
}

# Terraform required providers
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.67.0"  # Pinning to a specific stable version
    }
  }
  required_version = ">= 1.0.0"
}