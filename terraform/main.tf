provider "aws" {
  region = "us-east-1"
  access_key = "AKIAQ3EGUEPEZCOX3MWA"
  secret_key = "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"
}

module "vpc" {
  source = "./modules/vpc"
}

module "s3" {
  source = "./modules/s3"
}

module "iam" {
  source = "./modules/iam"
}

module "sns" {
  source = "./modules/sns"
}

module "glue" {
  source = "./modules/glue"
}

module "macie" {
  source = "./modules/macie"
  bucket_names = module.s3.bucket_names
}

module "cloudwatch" {
  source = "./modules/cloudwatch"
  alarm_topic_arn = module.sns.alarm_topic_arn
  bucket_names = module.s3.bucket_names
}
