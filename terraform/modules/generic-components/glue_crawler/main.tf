resource "aws_glue_crawler" "s3_target_crawler" {
  for_each  = var.glue_s3_crawler_map

  database_name = each.value.target_db
  name          = "catalog_${each.value.source_db}_to_${each.value.target_db}"
  role          = var.role_arn
  description   = each.value.description
  schedule      = each.value.on_schedule

  dynamic "s3_target" {
    for_each = split(",", each.value.s3_target)
    content {
      path = s3_target.value
    }
  }

  lineage_configuration {
    crawler_lineage_settings = lookup(var.cl_setting_options, each.value.cl_setting)
  }

  schema_change_policy {
    delete_behavior = lookup(var.delete_behavior_options, each.value.delete_behavior)
    update_behavior = lookup(var.update_behavior_options, each.value.update_behavior)
  }

  recrawl_policy {
    recrawl_behavior = lookup(var.recrawl_behavior_options, each.value.recrawl_behavior)
  }

  tags = {
    project     = var.project
    environment = var.environment
    Name        = "catalog_${each.value.source_db}_to_${each.value.target_db}"
    owner       = var.owner
    terraform   = "yes"
  }
}

resource "aws_glue_crawler" "jdbc_crawler" {
  for_each  = var.glue_jdbc_crawler_map

  database_name = "${each.value.source_dataset}_${each.value.source_db}"
  name          = "catalog_${each.value.source_dataset}_${each.value.source_db}_tables"
  role          = var.role_arn
  description   = each.value.description
  schedule      = each.value.on_schedule

  dynamic "jdbc_target" {
    for_each = split(",", each.value.jdbc_target_path)
    content {
      connection_name = each.value.jdbc_connector
      path = "${each.value.source_db}/${jdbc_target.value}"
    }
  }

  lineage_configuration {
    crawler_lineage_settings = lookup(var.cl_setting_options, each.value.cl_setting)
  }

  schema_change_policy {
    delete_behavior = lookup(var.delete_behavior_options, each.value.delete_behavior)
    update_behavior = lookup(var.update_behavior_options, each.value.update_behavior)
  }

  recrawl_policy {
    recrawl_behavior = lookup(var.recrawl_behavior_options, each.value.recrawl_behavior)
  }

  tags = {
    project     = var.project
    environment = var.environment
    Name        = "catalog_${each.value.source_dataset}_${each.value.source_db}_tables"
    owner       = var.owner
    terraform   = "yes"
  }
}
