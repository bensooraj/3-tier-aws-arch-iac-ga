locals {
  environment                   = var.default_tags["environment"]
  stack_name                    = var.default_tags["stack_name"]
  primary_ssm_parameter_prefix  = "/${var.primary_region}/${local.environment}/${local.stack_name}"
  failover_ssm_parameter_prefix = "/${var.failover_region}/${local.environment}/${local.stack_name}"
}

module "primary_network" {
  providers = {
    aws = aws.primary
  }
  source        = "../common/modules/network"
  vpc_cidr      = var.vpc_cidr
  all_ipv4_cidr = var.all_ipv4_cidr
}

module "failover_network" {
  count = var.create_failover ? 1 : 0
  providers = {
    aws = aws.failover
  }
  source        = "../common/modules/network"
  vpc_cidr      = var.vpc_cidr
  all_ipv4_cidr = var.all_ipv4_cidr
}
