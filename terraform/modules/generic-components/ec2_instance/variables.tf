variable "name" {
}

variable "function" {
}

#variable "number_of_instances" { default = 1}
variable "environment" {
}

variable "project" {}

variable "owner" {
  description = "Owner of the resource"
}

variable "instance_type" {
}

variable "image_id" {
}

variable "subnet_id" {
}


variable "security_groups" {
  default = []
}

variable "disable_api_termination" {
  default = true
}

variable "associate_public_ip" {
  default = false
}

variable "key_name" {
  default = null
}

variable "user_data" {
  default = null
}

variable "iam_instance_profile" {
  default = null
}

variable "cpu_credits" {
  default = "unlimited"
}

#variable "sns_subscription" {}

variable "root_ebs_size" {
  default = "80"
}

variable "root_ebs_type" {
  default = "gp2"
}

variable "ebs_optimized" {
  default = true
}

variable "delete_ebs_on_terminate" {
  default = true
}

variable "lifecycle_ignore_changes" {
  default = ["user_data", "ami"]
}

#variable "lifecycle_prevent_destroy" { default = true }

variable "monitor_memory" {
  default = "true"
}

variable "sns_topic" {
  default = null
}

variable "detailed_monitoring_enabled" {
  default = true
}

variable "cloudwatch_status" {
  description = "boolean, set false to disable alarms"
  default     = true
}

variable "cloudwatch_cpu" {
  description = "boolean, set false to disable alarms"
  default     = true
}

variable "cloudwatch_disk_space" {
  description = "boolean, set false to disable alarms"
  default     = true
}

variable "cloudwatch_ebs_credits" {
  description = "boolean, set false to disable alarms"
  default     = true
}

variable "cloudwatch_memory" {
  description = "boolean, set false to disable alarms"
  default     = true
}

variable "ebs_block_device" {
  description = "Additional EBS block devices to attach to the instance"
  type        = list(map(string))
  default     = []
}

variable "local_exec_command" {
  default = null
}

variable "delete_nic_on_termination" {
  default = true
}

variable "private_ips" {
  default = null
}

variable "availability_zone" {
  default = "us-east-1a"
}