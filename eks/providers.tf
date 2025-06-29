provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      "Environment" = var.environment
      "Terraform"     = "true"
    }
  }
}
terraform {
  backend "s3" {}
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
     helm = {
      source = "hashicorp/helm"
      version = "~>2.11.0"
    }
  }
}