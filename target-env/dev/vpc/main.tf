terraform {
  required_version = "0.14.3"
  #backend "s3" {
  #  bucket = ""
  #  region = "us-east-1"
  #}
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.15"
    }
  }
}

