# Primary network SSM parameters
resource "aws_ssm_parameter" "vpc_id" {
  type        = "String"
  name        = "${local.primary_ssm_parameter_prefix}/vpc_id"
  description = "VPC ID for the primary network."
  value       = module.primary_network.vpc_id
  tags        = var.default_tags
}

resource "aws_ssm_parameter" "web_subnet_ids" {
  type        = "StringList"
  name        = "${local.primary_ssm_parameter_prefix}/web_subnet_ids"
  description = "Public subnet IDs for the primary network."
  value       = join(",", module.primary_network.web_subnet_ids)
  tags        = var.default_tags
}

resource "aws_ssm_parameter" "app_subnet_ids" {
  type        = "StringList"
  name        = "${local.primary_ssm_parameter_prefix}/app_subnet_ids"
  description = "Private subnet IDs for the primary network."
  value       = join(",", module.primary_network.app_subnet_ids)
  tags        = var.default_tags
}

resource "aws_ssm_parameter" "data_subnet_ids" {
  type        = "StringList"
  name        = "${local.primary_ssm_parameter_prefix}/data_subnet_ids"
  description = "Private subnet IDs for the primary network."
  value       = join(",", module.primary_network.data_subnet_ids)
  tags        = var.default_tags
}

# Failover network SSM parameters
resource "aws_ssm_parameter" "failover_vpc_id" {
  count       = var.create_failover ? 1 : 0
  type        = "String"
  name        = "${local.failover_ssm_parameter_prefix}/vpc_id"
  description = "VPC ID for the failover network."
  value       = module.failover_network[0].vpc_id
  tags        = var.default_tags
}

resource "aws_ssm_parameter" "failover_web_subnet_ids" {
  count       = var.create_failover ? 1 : 0
  type        = "StringList"
  name        = "${local.failover_ssm_parameter_prefix}/web_subnet_ids"
  description = "Public subnet IDs for the failover network."
  value       = join(",", module.failover_network[0].web_subnet_ids)
  tags        = var.default_tags
}

resource "aws_ssm_parameter" "failover_app_subnet_ids" {
  count       = var.create_failover ? 1 : 0
  type        = "StringList"
  name        = "${local.failover_ssm_parameter_prefix}/app_subnet_ids"
  description = "Private subnet IDs for the failover network."
  value       = join(",", module.failover_network[0].app_subnet_ids)
  tags        = var.default_tags
}

resource "aws_ssm_parameter" "failover_data_subnet_ids" {
  count       = var.create_failover ? 1 : 0
  type        = "StringList"
  name        = "${local.failover_ssm_parameter_prefix}/data_subnet_ids"
  description = "Private subnet IDs for the failover network."
  value       = join(",", module.failover_network[0].data_subnet_ids)
  tags        = var.default_tags
}
