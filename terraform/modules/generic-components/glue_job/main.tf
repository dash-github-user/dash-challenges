resource "aws_cloudwatch_log_group" "offload_job_log_group" {
  for_each  = var.glue_job_map
  
  name      = "offload_${each.value.source_db}_${each.value.source_schema}_tables_for_${each.value.target_db}_as_parquet"
  retention_in_days = 14
}

resource "aws_glue_job" "offload_job" {
  for_each = var.glue_job_map

  name        = "offload_${each.value.source_db}_${each.value.source_schema}_tables_for_${each.value.target_db}_as_parquet"
  # name        = var.name
  role_arn    = var.role_arn
  connections = [ "${each.value.source_dataset}" ]
  command {
    python_version  = "3"
    script_location = each.value.script
  }
  default_arguments = {
    "--TempDir"                          = "s3://aws-glue-temporary-us-east-1/${var.environment}"
    "--continuous-log-logGroup"          = "offload_${each.value.source_db}_${each.value.source_schema}_tables_for_${each.value.target_db}_as_parquet"
    "--enable-continuous-cloudwatch-log" = "true"
    "--enable-continuous-log-filter"     = "true"
    "--enable-glue-datacatalog"          = ""
    "--enable-metrics"                   = ""
    "--enable-spark-ui"                  = "true"
    "--encryption-type"                  = "sse-s3"
    "--job-bookmark-option"              = lookup(var.bookmark_options, var.bookmark)
    "--job-language"                     = each.value.language
    "--spark-event-logs-path"            = "s3://aws-logs-us-east-1/glue/${var.environment}"
    "--source_db"                        = "${each.value.source_dataset}_${each.value.source_db}"
    "--source_table_names"                = join(";", [for t in split(";", each.value.table_names) : format("${each.value.source_db}_${each.value.source_schema}_%s", t)])
    "--s3_root_path"                     = "${each.value.s3_root_path}"
    "--partitionkeys"                    = each.value.partition_keys
    "--target_db"                        = each.value.target_db
    "--target_table_names"                = each.value.table_names

  }
  glue_version              = each.value.glue_version
  max_retries               = each.value.max_retries
  number_of_workers         = each.value.concurrent_runs * 2
  timeout                   = each.value.timeout
  worker_type               = each.value.worker_type
  execution_property {
    max_concurrent_runs = each.value.concurrent_runs
  }
  tags = {
    project     = var.project
    environment = var.environment
    name        = "offload_${each.value.source_db}_${each.value.source_schema}_tables_for_${each.value.target_db}_as_parquet"
    owner       = var.owner
    terraform   = "yes"
  }
}