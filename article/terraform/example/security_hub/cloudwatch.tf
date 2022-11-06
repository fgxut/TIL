resource "aws_cloudwatch_log_metric_filter" "example" {
  for_each = local.alarms

  name           = each.key
  pattern        = each.value
  log_group_name = aws_cloudwatch_log_group.example.name

  metric_transformation {
    name      = each.key
    namespace = "LogMetrics"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "example" {
  for_each = local.alarms

  alarm_name          = each.key
  alarm_description   = each.key
  statistic           = "Average"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold           = 1
  period              = 300
  evaluation_periods  = 1
  metric_name         = each.key
  namespace           = "LogMetrics"
  treat_missing_data  = "notBreaching"
  alarm_actions       = [aws_sns_topic.example.arn]
  ok_actions          = [aws_sns_topic.example.arn]
}
