##############
### Common ###
##############
# DC1-21 Configure Back-End Infrastructure
variable "environment" {
  default = "dev"
}

variable "project" {
  default = "dash"
}

variable "owner" {
  default = "dash_team"
}

variable "vpc_id" {
  default = "vpc-022c3b7566d1768c1"
}

variable "rds_subnet_id" {
  default = [
    "subnet-0340cbbb748ao1fb0",
  ]
}

variable "rds_security_group" {
  default = "sg-08a553028051acbe0"
}

variable "aws_glue_service_role" {
  default = "arn:aws:iam::009789063714:role/DASH-GlueExecutionRole"
}
