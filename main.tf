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

resource "aws_s3_bucket_website_configuration" "web_prueba" {
  bucket = aws_s3_bucket.bucket_prueba.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

resource "aws_vpc" "vpc_prueba" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "devops-vpc-prueba"
  }
}

output "s3_bucket_name" {
  value = aws_s3_bucket.bucket_prueba.bucket
}

output "s3_website_endpoint" {
  value = aws_s3_bucket_website_configuration.web_prueba.website_endpoint
}
