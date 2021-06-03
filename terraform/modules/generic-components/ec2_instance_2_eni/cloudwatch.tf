resource "aws_cloudwatch_metric_alarm" "module_ec2_cloudwatch_status" {
  count                     = var.cloudwatch_status ? 1 : 0
  alarm_name                = "${local.name}-status-check"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "StatusCheckFailed"
  namespace                 = "AWS/EC2"
  period                    = "300"
  statistic                 = "Average"
  threshold                 = "1"
  alarm_description         = "This metric monitors ec2 status"
  insufficient_data_actions = [var.sns_topic]
  alarm_actions             = [var.sns_topic]
  ok_actions                = [var.sns_topic]

  dimensions = {
    InstanceId = aws_instance.ec2_instance.id
  }

  tags = {
    project     = var.project
    environment = lower(var.environment)
    owner       = var.owner
    terraform   = "yes"
  }

}

resource "aws_cloudwatch_metric_alarm" "module_ec2_cloudwatch_cpu" {
  count                     = var.cloudwatch_cpu ? 1 : 0
  alarm_name                = "${local.name}-cpu"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "300"
  statistic                 = "Average"
  threshold                 = "85"
  alarm_description         = "This metric monitors ec2 cpu usage"
  insufficient_data_actions = [var.sns_topic]
  alarm_actions             = [var.sns_topic]
  ok_actions                = [var.sns_topic]

  dimensions = {
    InstanceId = aws_instance.ec2_instance.id
  }

  tags = {
    project     = var.project
    environment = lower(var.environment)
    owner       = var.owner
    terraform   = "yes"
  }
}

resource "aws_cloudwatch_metric_alarm" "module_ec2_memory" {
  count                     = var.cloudwatch_memory ? 1 : 0
  alarm_name                = "${local.name}-memory"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "mem_used_percent"
  namespace                 = "CWAgent"
  period                    = "300"
  statistic                 = "Average"
  threshold                 = "85"
  alarm_description         = "This metric monitors ec2 memory usage"
  insufficient_data_actions = [var.sns_topic]
  alarm_actions             = [var.sns_topic]
  ok_actions                = [var.sns_topic]

  dimensions = {
    InstanceId = aws_instance.ec2_instance.id
  }

  tags = {
    project     = var.project
    environment = lower(var.environment)
    owner       = var.owner
    terraform   = "yes"
  }
}

resource "aws_cloudwatch_metric_alarm" "module_ec2_disk_space" {
  count                     = var.cloudwatch_disk_space ? 1 : 0
  alarm_name                = "${local.name}-disk-space"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "disk_used_percent"
  namespace                 = "CWAgent"
  period                    = "300"
  statistic                 = "Average"
  threshold                 = "80"
  alarm_description         = "This metric monitors ec2 disk space"
  insufficient_data_actions = [var.sns_topic]
  alarm_actions             = [var.sns_topic]
  ok_actions                = [var.sns_topic]

  dimensions = {
    path       = "/"
    InstanceId = aws_instance.ec2_instance.id
    device     = "rootfs"
    fstype     = "rootfs"
  }

  tags = {
    project     = var.project
    environment = lower(var.environment)
    owner       = var.owner
    terraform   = "yes"
  }
}

# resource "aws_cloudwatch_metric_alarm" "module_ec2_disk_io" {
#     count                  = "${var.cloudwatch ? 1 : 0}"
#     alarm_name                = "${local.name}-disk-io"
#     comparison_operator       = "GreaterThanOrEqualToThreshold"
#     evaluation_periods        = "1"
#     metric_name               = "diskio_io_time"
#     namespace                 = "CWAgent"
#     period                    = "300"
#     statistic                 = "Average"
#     threshold                 = "3000"
#     alarm_description         = "This metric monitors ec2 disk io"
#     insufficient_data_actions = ["${var.sns_topic}"]
#     alarm_actions = ["${var.sns_topic}"]
#     ok_actions = ["${var.sns_topic}"]
#     dimensions = {
#         InstanceId = "${aws_instance.ec2_instance.id}"
#         name = "xvda"
#     }
# }

resource "aws_cloudwatch_metric_alarm" "module_ec2_ebs_credits" {
  count                     = var.cloudwatch_ebs_credits ? 1 : 0
  alarm_name                = "${local.name}-ebs-burst-balance"
  comparison_operator       = "LessThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "BurstBalance"
  namespace                 = "AWS/EBS"
  period                    = "300"
  statistic                 = "Average"
  threshold                 = "30"
  alarm_description         = "This metric monitors ebs burst balance"
  insufficient_data_actions = [var.sns_topic]
  alarm_actions             = [var.sns_topic]
  ok_actions                = [var.sns_topic]

  dimensions = {
    VolumeId = aws_instance.ec2_instance.root_block_device[0].volume_id
  }

  tags = {
    project     = var.project
    environment = lower(var.environment)
    owner       = var.owner
    terraform   = "yes"
  }
}

# resource "aws_cloudwatch_metric_alarm" "module_ec2_ebs_queue_length" {
#     count                  = "${var.cloudwatch ? 1 : 0}"
#     alarm_name                = "${local.name}-ebs-queue-length"
#     comparison_operator       = "GreaterThanOrEqualToThreshold"
#     evaluation_periods        = "2"
#     metric_name               = "BurstBalance"
#     namespace                 = "AWS/EBS"
#     period                    = "300"
#     statistic                 = "Average"
#     threshold                 = "3"
#     alarm_description         = "This metric monitors ebs queue length"
#     insufficient_data_actions = ["${var.sns_topic}"]
#     alarm_actions = ["${var.sns_topic}"]
#     ok_actions = ["${var.sns_topic}"]
#     dimensions = {
#         VolumeID = "${aws_instance.ec2_instance.root_block_device.0.volume_id}"
#     }
# }
