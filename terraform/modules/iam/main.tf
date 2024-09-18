resource "aws_iam_group" "engineer" {
  name = "engineer"
  path = "/users/"
}

resource "aws_iam_group_policy" "engineer_policy" {
  name  = "engineer_policy"
  group = aws_iam_group.engineer.name
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "s3:*",
          "glue:*",
          "emr:*",
          "cloudwatch:ListMetrics",
          "cloudwatch:GetMetricData"
        ],
        "Resource": "*"
      }
    ]
  })
}

resource "aws_iam_group" "admin" {
  name = "admin"
  path = "/users/"
}

resource "aws_iam_group_policy" "admin_policy" {
  name  = "admin_policy"
  group = aws_iam_group.admin.name
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": ["*"],
        "Resource": "*"
      }
    ]
  })
}

resource "aws_iam_group" "user" {
  name = "user"
  path = "/users/"
}

resource "aws_iam_group_policy" "user_policy" {
  name  = "user_policy"
  group = aws_iam_group.user.name
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "s3:GetObject",
          "s3:ListBucket",
          "elasticmapreduce:ListClusters",
          "elasticmapreduce:DescribeCluster",
          "elasticmapreduce:ListSteps",
          "elasticmapreduce:DescribeStep"
        ],
        "Resource": "*"
      }
    ]
  })
}

resource "aws_iam_role" "emr_serverless_role" {
  name = "emr_serverless_service_role"

  assume_role_policy = jsonencode({
    "Version" = "2012-10-17"
    "Statement" = [
      {
        "Action" = "sts:AssumeRole"
        "Effect" = "Allow"
        "Sid" = ""
        "Principal" = {
          "Service" = "emr-serverless.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "emr_serverless_policy" {
  name   = "emr_serverless_policy"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ],
        "Resource": [
            "arn:aws:s3:::emr-serverless-logs-lake",
            "arn:aws:s3:::emr-serverless-logs-lake/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_policy" {
    role = aws_iam_role.emr_serverless_role.name
    policy_arn = aws_iam_policy.emr_serverless_policy.arn
}