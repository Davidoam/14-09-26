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

resource "aws_s3_bucket_public_access_block" "web_prueba" {
  bucket = aws_s3_bucket.bucket_prueba.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
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

resource "aws_s3_bucket_policy" "web_public_read" {
  bucket = aws_s3_bucket.bucket_prueba.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.bucket_prueba.arn}/*"
      }
    ]
  })

  depends_on = [
    aws_s3_bucket_public_access_block.web_prueba
  ]
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
