data "aws_ssm_parameter" "rds_password" {
  name = "${var.rds_password_ssm_path}"
}

locals {
  identifier = "${var.environment}-${var.project}-${var.name}"
}
