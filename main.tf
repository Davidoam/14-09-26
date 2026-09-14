terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "bucket_prueba" {
  bucket = "devops-prueba-david-2026-v2"
}

resource "aws_vpc" "vpc_prueba" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "devops-vpc-prueba"
  }
}

