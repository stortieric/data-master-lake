resource "aws_sns_topic" "alarm_topic" {
    name = "my_alarm_topic"
}

resource "aws_sns_topic_subscription" "email_subscription" {
    topic_arn = aws_sns_topic.alarm_topic.arn
    protocol  = "email"
    endpoint  = "ericstorti@outlook.com" # Substitua pelo seu e-mail
}

output "alarm_topic_arn" {
    value = aws_sns_topic.alarm_topic.arn
}