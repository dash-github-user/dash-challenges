output "endpoint" {
  description = "DB Endpoint"
  value       = aws_db_instance.rds.endpoint
}

output "port" {
  description = "DB port"
  value       = aws_db_instance.rds.port
}

output "dbname" {
  description = "DB name"
  value       = aws_db_instance.rds.name
}

output "airflow_connect_string" {
  description = "connection string to be used by airflow"
  value       = "postgresql+psycopg2://${var.rds_db_username}:${data.aws_ssm_parameter.rds_password.value}@${aws_db_instance.rds.endpoint}/${aws_db_instance.rds.name}"
}
