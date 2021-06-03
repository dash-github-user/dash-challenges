resource "aws_db_event_subscription" "subscription" {
  count = var.sns_topic != null ? 1 : 0

  name      = "${local.identifier}-subscription"
  sns_topic = var.sns_topic

  source_type = "db-instance"
  source_ids  = [aws_db_instance.rds.id]

  event_categories = [
    "availability",
    "configuration change",
    "deletion",
    "failover",
    "failure",
    "low storage",
    "maintenance",
    "notification",
    "read replica",
    "recovery",
    "restoration",
  ]

  depends_on = [aws_db_instance.rds]

  lifecycle {
    ignore_changes        = [name]
    create_before_destroy = true
  }
}

