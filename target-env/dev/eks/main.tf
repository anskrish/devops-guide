provider "aws" {
  region  = var.region
}

terraform {
  required_version = "= 0.14.3"
  backend "s3" {
    bucket = "terraform-infrastructure-plate"
    region = "us-east-1"
  }
}
