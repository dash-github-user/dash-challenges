variable "environment" {}

variable "project" {}

variable "owner" {
  description = "Owner of the resource"
}

variable "role_arn" {}

variable "connections" {
  type    = list(string)
  default = []
}

variable "dpu" {
    default = 2
}

variable "glue_job_map" {
    type = map(map(any))
} 

variable "bookmark" {
    default     = "enabled"
    description = "It can be enabled, disabled or paused."
}

variable "bookmark_options" {
    type = map(string)

    default = {
        enabled  = "job-bookmark-enable"
        disabled = "job-bookmark-disable"
        paused   = "job-bookmark-pause"
    }
}

variable "max_retries" {
    default = 0
}

variable "timeout" {
    default = 2880
}

variable "max_concurrent" {
    default = 1
}

variable "glue_version" {
    default = "2.0"
}

variable "worker_type" {
    default = "G.2X"
}
