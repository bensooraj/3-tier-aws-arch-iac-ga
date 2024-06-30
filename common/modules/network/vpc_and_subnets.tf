# Locals
locals {
  web_subnet_cidrs = [
    cidrsubnet(var.vpc_cidr, 8, 0), # 10.0.0.0/24
    cidrsubnet(var.vpc_cidr, 8, 1), # 10.0.1.0/24
    cidrsubnet(var.vpc_cidr, 8, 2)  # 10.0.2.0/24
  ]
  app_subnet_cidrs = [
    cidrsubnet(var.vpc_cidr, 8, 3), # 10.0.3.0/24
    cidrsubnet(var.vpc_cidr, 8, 4), # 10.0.4.0/24
    cidrsubnet(var.vpc_cidr, 8, 5)  # 10.0.5.0/24
  ]
  data_subnet_cidrs = [
    cidrsubnet(var.vpc_cidr, 8, 6), # 10.0.6.0/24
    cidrsubnet(var.vpc_cidr, 8, 7), # 10.0.7.0/24
    cidrsubnet(var.vpc_cidr, 8, 8)  # 10.0.8.0/24
  ]

  availability_zones = data.aws_availability_zones.available.names
  application        = data.aws_default_tags.provider.tags.application
}

# VPC
resource "aws_vpc" "three_tier_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  tags = {
    Name = "${local.application}-vpc"
  }
}

# Subnets
resource "aws_subnet" "web_subnets" {
  count = length(local.web_subnet_cidrs)

  vpc_id            = aws_vpc.three_tier_vpc.id
  cidr_block        = local.web_subnet_cidrs[count.index]
  availability_zone = local.availability_zones[count.index]

  tags = {
    Name = "${local.application}-web-tier-${count.index}-${local.availability_zones[count.index]}"
  }
}

resource "aws_subnet" "app_subnets" {
  count = length(local.app_subnet_cidrs)

  vpc_id            = aws_vpc.three_tier_vpc.id
  cidr_block        = local.app_subnet_cidrs[count.index]
  availability_zone = local.availability_zones[count.index]

  tags = {
    Name = "${local.application}-app-tier-${count.index}-${local.availability_zones[count.index]}"
  }
}

resource "aws_subnet" "data_subnets" {
  count = length(local.data_subnet_cidrs)

  vpc_id            = aws_vpc.three_tier_vpc.id
  cidr_block        = local.data_subnet_cidrs[count.index]
  availability_zone = local.availability_zones[count.index]

  tags = {
    Name = "${local.application}-data-tier-${count.index}-${local.availability_zones[count.index]}"
  }
}
