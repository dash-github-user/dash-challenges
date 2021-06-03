variable "environment" {
  description = "Environment name"
}

variable "project" {
  description = "Name of the project"
}

variable "owner" {
  description = "Owner of the resource"
}

variable "name" {
}

variable "rds_instance_class" {
  description = "RDS instance class"
}

variable "rds_storage_type" {
  description = "RDS storage type"
  default     = "gp2"
}

variable "rds_allocated_storage" {
  description = "RDS allocated storage"
}

variable "rds_db_username" {
}

variable "rds_subnet_ids" {
}

variable "rds_engine_type" {
  description = "RDS The engine to use (postgres, mysql, etc)"
}

variable "rds_engine_version" {
  description = "RDS The engine version to use"
}

variable "backup_retention_period" {
  default     = 0
  description = "The number of days for which automated backups are retained. Setting this parameter to a positive number enables backups. Setting this parameter to 0 disables automated backups."
}

variable "backup_window" {
  default     = "22:00-23:00" #Daily backup starts at 10 PM. Duration 1 hour.
  description = "The daily time range (in UTC) during which automated backups are created if automated backups are enabled. Must not overlap with maintenance_window"
}

variable "maintenance_window" {
  default     = "Sat:00:00-Sat:05:00" #Every Saturday 12 AM to 3 AM
  description = "The weekly time range (in UTC) during which system maintenance can occur."
}

variable "auto_minor_version_upgrade" {
  default = true
}

variable "allow_major_version_upgrade" {
  default = true
}

variable "multi_az" {
  default = false
}

variable "sns_topic" {
  default = null
}

variable "iops" {
  description = "used by the io1 storage type"
  default     = 0
}

variable "storage_encrypted" {
  default = true
}

variable "deletion_protection" {
  default = true
}

variable "monitoring_role_arn" {
  default = "arn:aws:iam::667646328794:role/Enhanced-Monitoring-RDSRole"
}

variable "monitoring_interval" {
  description = "set 0 to disable, otherwise 30 or 60"
  default     = 0
}

variable "performance_insights_enabled" {
  default = false
}

variable "performance_insights_retention_period" {
  description = "must be 0, 7, or"
  default     = 0
}

variable "apply_immediately" {
  default = false
}

variable "rds_password_ssm_path" {
}

variable "vpc_id" {}

variable "rds_security_group" {
}

variable "skip_final_snapshot" {
  default = false
}
