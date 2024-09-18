variable "bucket_names" {
    type = list(string)
}

variable "enable_macie" {
    type = bool
    default = false
}

resource "aws_macie2_account" "search_sensitive_data" {
    count = var.enable_macie ? 1 : 0
    finding_publishing_frequency = "FIFTEEN_MINUTES"
}

resource "aws_macie2_classification_job" "find_sensitive_data" {
    count = var.enable_macie ? 1 : 0
    job_type = "ONE_TIME"
    name     = "find_sensitive_data"
    s3_job_definition {
        bucket_definitions {
            account_id = aws_macie2_account.search_sensitive_data[count.index].id
            buckets = var.bucket_names
        }
    }
    depends_on = [aws_macie2_account.search_sensitive_data]
}