variable "alarm_topic_arn" {
  type = string
}

variable "bucket_names" {
  type = list(string)
}

resource "aws_cloudwatch_metric_alarm" "s3_bucket_size_alarm" {
    for_each = toset(var.bucket_names)
    alarm_name = "${each.key}_size_alarm"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods  = "1"
    metric_name = "BucketSizeBytes"
    namespace = "AWS/S3"
    period = "86400"
    statistic = "Average"
    threshold = "2000000000" 
    dimensions = {
        BucketName = each.key
        StorageType = "StandardStorage"
    }
    alarm_description = "Dispara o alarme quando o bucket S3 excede 2GB"
    alarm_actions = [var.alarm_topic_arn]
}

/*
resource "aws_cloudwatch_metric_alarm" "glue_jobs_failed_alarm" {
    alarm_name = "glue_jobs_failed_alarm"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods  = "1"
    metric_name = "GlueFailedJobs"
    namespace = "AWS/Glue"
    period = "300"
    statistic = "Average"
    threshold = "1"
    dimensions = {
        JobName = "your-glue-job-name"
    }
    alarm_description = "Alarme de detecção de falha em job glue"
    alarm_actions = [var.alarm_topic_arn]
}

resource "aws_cloudwatch_metric_alarm" "emr_cluster_failed_steps_alarm" {
    alarm_name = "emr_cluster_failed_steps_alarm"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods = "1"
    metric_name = "IsFailed"
    namespace = "AWS/ElasticMapReduce"
    period = "300" 
    statistic = "Maximum"
    threshold = "1"
    dimensions = {
        JobFlowId = "your-job-flow-id"
    }
    alarm_description = "Detecção de falha no cluster EMR"
    alarm_actions = [var.alarm_topic_arn]
}*/

resource "aws_cloudwatch_metric_alarm" "macie_anomalies_alarm" {
    alarm_name = "macie_anomalies_alarm"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods  = "1"
    metric_name = "AnomalousObjectCount"
    namespace = "AWS/Macie"
    period = "86400" 
    statistic = "Sum"
    threshold = "10" 
    alarm_description = "Alarme que detecta mais de 10 dados sensíveis no Macie"
    alarm_actions = [var.alarm_topic_arn]
}
