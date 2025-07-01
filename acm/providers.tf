provider "aws" {
  region = "us-west-1"
  default_tags {
    tags = {
      "Environment" = var.environment
      "Managed"     = "true"
    }
  }
}
terraform {
  backend "s3" {
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
