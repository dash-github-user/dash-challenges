variable "environment" {}

variable "project" {}

variable "owner" {
  description = "Owner of the resource"
}

variable "role_arn" {}

variable "cl_setting" {
  default     = "enable"
  description = "Crawler Linage Settings can be eanble, or disable."
}

variable "cl_setting_options" {
    type = map(string)

    default = {
        enable  = "ENABLE"
        disable = "DISABLE"
    }
}

variable "delete_behavior" {
  default     = "deprecate"
  description = "It can be log, delete or deprecate."
}

variable "delete_behavior_options" {
    type = map(string)

    default = {
        log       = "LOG"
        delete    = "DELETE_FROM_DATABASE"
        deprecate = "DEPRECATE_IN_DATABASE"
    }
}

variable "update_behavior" {
  default     = "update"
  description = "It can be log, or update."
}

variable "update_behavior_options" {
    type = map(string)

    default = {
        log    = "LOG"
        update = "UPDATE_IN_DATABASE"
    }
}

variable "recrawl_behavior" {
  default     = "all"
  description = "It can be all, or new."
}

variable "recrawl_behavior_options" {
    type = map(string)

    default = {
        all = "CRAWL_EVERYTHING"
        new = "CRAWL_NEW_FOLDERS_ONLY"
    }
}

variable "s3_exclusions" {
  type    = list(string)
  default = []
}

variable "glue_s3_crawler_map" {
    type = map(map(any))
    default = {}
}

variable "glue_jdbc_crawler_map" {
    type = map(map(any))
    default = {}
}
