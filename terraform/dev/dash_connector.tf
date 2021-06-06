# DC1-21 Configure Back-End Infrastructure
resource "aws_glue_connection" "dash_connector" {
  connection_properties = {
    JDBC_CONNECTION_URL = "${data.aws_ssm_parameter.dash_connection_string.value}"
    PASSWORD            = "${data.aws_ssm_parameter.dash_rds_password.value}"
    USERNAME            = "${data.aws_ssm_parameter.dash_rds_account.value}"
  }

  name = "iqies"

  physical_connection_requirements {
    availability_zone      = "us-east-1d"
    security_group_id_list = [
        "${data.aws_security_group.rds_security_group.value}"
        ]
    subnet_id = "${data.aws_security_group.rds_subnet_id.value}"
  }
}
