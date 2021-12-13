provider "aws" {
  region  = var.region
}

terraform {
  required_version = "= 1.0.8"
  #backend "s3" {
  #  bucket = ""
  #  region = "us-west-2"
  #}
}


data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

