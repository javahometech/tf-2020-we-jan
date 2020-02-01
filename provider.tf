provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket         = "javahome-2020-tf"
    key            = "terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "javahome-tf"
  }
}