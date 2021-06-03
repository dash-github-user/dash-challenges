#https://github.com/pgaudit/pgaudit/blob/master/README.md#settings
resource "aws_db_parameter_group" "pg10" {
  #count = "${var.rds_engine_version == "10.6" ? 1 : 0}"
  name   = "${local.identifier}-pg-10"
  family = "postgres10"

  parameter {
    name  = "client_min_messages"
    value = "error"
  }

  parameter {
    name  = "log_connections"
    value = "1"
  }

  parameter {
    name         = "log_destination"
    value        = "stderr"
    apply_method = "pending-reboot"
  }

  parameter {
    name  = "log_disconnections"
    value = "1"
  }

  parameter {
    name  = "log_error_verbosity"
    value = "default"
  }


  # security remediation from jira ticket hdm-2779
  parameter {
    name  = "pgaudit.log"
    value = "all,-misc,ddl,role,read,write"
    apply_method = "immediate"
  }

  # security remediation from jira ticket hdm-2779
  parameter {
    name  = "pgaudit.log_catalog"
    value = "1"
    apply_method = "immediate"
  }

  # security remediation from jira ticket hdm-2779
  parameter {
    name  = "pgaudit.log_level"
    value = "log"
    apply_method = "immediate"
  }

  # security remediation from jira ticket hdm-2779
  parameter {
    name  = "pgaudit.log_parameter"
    value = "1"
    apply_method = "immediate"
  }

  # parameter {
  #   name  = "pgaudit.log_relation"
  #   value = "1"
  # }

  # security remediation from jira ticket hdm-2779
  parameter {
    name  = "pgaudit.log_statement_once"
    value = "0"
    apply_method = "immediate"
  }

  # security remediation from jira ticket hdm-2779
  parameter {
    name         = "pgaudit.role"
    value        = "rds_pgaudit"
    apply_method = "immediate"
  }

  parameter {
    name         = "rds.force_ssl"
    value        = "0"
    apply_method = "pending-reboot"
  }

  # security remediation from jira ticket hdm-2779
  parameter {
    name         = "shared_preload_libraries"
    value        = "pgaudit"
    apply_method = "pending-reboot"
  }

  parameter {
    name  = "tcp_keepalives_idle"
    value = "10"
  }

  parameter {
    name  = "tcp_keepalives_idle"
    value = "10"
  }

  parameter {
    name  = "tcp_keepalives_interval"
    value = "10"
  }

  parameter {
    name  = "log_rotation_size"
    value = "204800"
    apply_method = "immediate"
  }

  parameter {
    name  = "log_rotation_age"
    value = "1440"
    apply_method = "immediate"
  }

  parameter {
    name  = "log_hostname"
    value = "0"
    apply_method = "immediate"
  }

  lifecycle {
    ignore_changes        = [name]
    create_before_destroy = true
  }

  tags = {
    project     = var.project
    owner       = var.owner
    environment = lower(var.environment)
    terraform   = "yes"
  }
}

