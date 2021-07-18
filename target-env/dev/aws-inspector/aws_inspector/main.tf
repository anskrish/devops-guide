provider "aws" {
  region = var.region
}

terraform {
  required_version = "= 0.14.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.15.0"
    }
  }
  backend "s3" {
    bucket = "krishna-terraform"
    key = "aws_inspector/terraform.tfstate"
    region = "us-west-2"
  }
}


data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

