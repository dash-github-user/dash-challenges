variable "name" {
}

variable "project" {
}

variable "owner" {}

variable "environment" {}

variable "filename" {
}

variable "role" {
}

variable "timeout" {
  default = 900
}

variable "runtime" {
  default = "dotnetcore2.1"
}

variable "handler" {
  default = "lambda_function.lambda_handler"
}

variable "cron_schedule" {
  description = "Should be in the following format, cron(59 23 * * *)"
  default     = "cron(30 23 * * ? *)"
}

variable "memory_size" {
  default = 512
}

variable "slack_url_ssm_path" {}

variable "SQSQueueNameOnFailure" {
   description = "sqs queue to ingest error messages"
   default = ""
}

variable "SQSQueueNameOnSuccess" {
   description = "sqs queue to ingest success messages"
   default = ""
}

variable "slack_template" {
   description = "HQR message format for slack posting "
   default = ""
}

variable "sqs_template" {
   description = "HQR message format for sqs queue messing "
   default = ""
}

variable "webhook_cdr_data_load_link" {
   description = "Slack webhook slack posting "
}

variable "dataset" {
   description = "HQR Messaging formating "
   default = ""
}
