terraform {
  backend "s3" {
    bucket = "terraform-state-pruebadiego"
    key    = "project/terraform.tfstate"
    region = "us-east-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>6.63.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = var.project
      Environment = var.environment
      Owner       = var.owner
      Costcenter  = var.costcenter
    }
  }
}