# DC1-21 Configure Back-End Infrastructure
data "aws_security_group" "rds_security_group" {
  id = var.rds_security_group
}

data "aws_security_group" "rds_subnet_id" {
  id = var.rds_subnet_id
}

# iQies Postgres Database Connection String
data "aws_ssm_parameter" "dash_rds_connection_string" {
  name = "/${var.project}/${var.environment}/dash_rds_connect_string"
}

data "aws_ssm_parameter" "dash_rds_account" {
  name = "/${var.project}/${var.environment}/dash_rds_account"
}

data "aws_ssm_parameter" "dash_rds_password" {
  name = "/${var.project}/${var.environment}/dash_rds_password"
}
