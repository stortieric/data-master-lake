resource "aws_s3_bucket" "bronze" {
    bucket = "bronze-data-bucket"

    tags = {
        Name = "lake"
        Environment = "prd"
    }
}

resource "aws_s3_bucket_versioning" "versioning_bronze" {
    bucket = aws_s3_bucket.bronze.id
    versioning_configuration {
        status = "Enabled"
    }
}

resource "aws_s3_bucket" "silver" {
    bucket = "silver-data-bucket"
    tags = {
        Name = "lake"
        Environment = "prd"
    }
}

resource "aws_s3_bucket_versioning" "versioning_silver" {
    bucket = aws_s3_bucket.silver.id
    versioning_configuration {
        status = "Enabled"
    }
}

resource "aws_s3_bucket" "gold" {
    bucket = "gold-data-bucket"
    tags = {
        Name = "lake"
        Environment = "prd"
    }
}

resource "aws_s3_bucket_versioning" "versioning_gold" {
    bucket = aws_s3_bucket.gold.id
    versioning_configuration {
        status = "Enabled"
    }
}

resource "aws_s3_bucket" "emr_logs" {
    bucket = "emr-serverless-logs-lake"
    tags = {
        Name = "compute"
        Environment = "prd"
    }
}

output "bucket_names" {
  value = [
    aws_s3_bucket.bronze.bucket,
    aws_s3_bucket.silver.bucket,
    aws_s3_bucket.gold.bucket
  ]
}