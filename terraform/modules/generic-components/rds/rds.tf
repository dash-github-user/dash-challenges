resource "aws_db_subnet_group" "rds_subnet" {
  name = "${local.identifier}-rds-subnet"

  subnet_ids = var.rds_subnet_ids

  tags = {
    project     = var.project
    environment = var.environment
    Name        = "${local.identifier}-rds-subnet"
    owner       = var.owner
    terraform   = "yes"
  }

  lifecycle {
    ignore_changes = [name]
  }
}

resource "aws_db_instance" "rds" {
  identifier = local.identifier
  name       = replace(local.identifier, "-", "_") #name of the database

  maintenance_window          = var.maintenance_window
  auto_minor_version_upgrade  = var.auto_minor_version_upgrade
  allow_major_version_upgrade = var.allow_major_version_upgrade
  apply_immediately           = var.apply_immediately

  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window
  copy_tags_to_snapshot   = true
  skip_final_snapshot     = var.skip_final_snapshot
  deletion_protection     = var.deletion_protection

  enabled_cloudwatch_logs_exports = ["postgresql"]
  engine                          = var.rds_engine_type
  engine_version                  = var.rds_engine_version
  instance_class                  = var.rds_instance_class
  db_subnet_group_name            = aws_db_subnet_group.rds_subnet.name
  vpc_security_group_ids          = var.rds_security_group
  multi_az                        = var.multi_az
  parameter_group_name            = aws_db_parameter_group.pg10.name

  username = var.rds_db_username
  password = data.aws_ssm_parameter.rds_password.value

  storage_type      = var.rds_storage_type
  iops              = var.iops
  storage_encrypted = var.storage_encrypted
  allocated_storage = var.rds_allocated_storage

  monitoring_role_arn = var.monitoring_interval > "0" ? var.monitoring_role_arn : null
  monitoring_interval = var.monitoring_interval

  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_retention_period = var.performance_insights_retention_period


  tags = {
    project     = var.project
    environment = var.environment
    Name        = local.identifier
    owner       = var.owner
    terraform   = "yes"
  }

  lifecycle {
    ignore_changes = [
      name,
      identifier,
      engine_version
    ]
    create_before_destroy = true
  }
}

