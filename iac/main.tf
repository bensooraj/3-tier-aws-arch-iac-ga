module "network" {
  source        = "./modules/network"
  vpc_cidr      = var.vpc_cidr
  all_ipv4_cidr = var.all_ipv4_cidr
  my_ipv4_cidr  = var.my_ipv4_cidr
  ssh_port      = var.ssh_port
  web_port      = var.web_port
  app_port      = var.app_port
  db_port       = var.db_port
}

module "compute" {
  source         = "./modules/compute"
  ssh_public_key = var.ssh_public_key

  # VPC and Subnet IDs
  vpc_id          = module.network.vpc_id
  web_subnet_ids  = module.network.web_subnet_ids
  app_subnet_ids  = module.network.app_subnet_ids
  data_subnet_ids = module.network.data_subnet_ids

  # Bastion Host
  bastion_host_ami_id        = var.bastion_host_ami_id
  bastion_host_instance_type = var.bastion_host_instance_type
  bastion_host_sg_id         = module.network.bastion_host_sg_id

  # App Server
  app_server_ami_id        = var.app_server_ami_id
  app_server_instance_type = var.app_server_instance_type
  app_sg_id                = module.network.app_sg_id
  ssh_from_bastion_sg_id   = module.network.ssh_from_bastion_sg_id
  app_port                 = var.app_port

  # Application Load Balancer
  alb_sg_id = module.network.alb_sg_id
  web_port  = var.web_port

  # Auto Scaling Group
  asg_min_size         = var.asg_min_size
  asg_desired_capacity = var.asg_desired_capacity
  asg_max_size         = var.asg_max_size
}

module "dns" {
  source = "./modules/dns"

  dns_zone_name = var.dns_zone_name
  alb_dns_name  = module.compute.alb_dns_name
  alb_zone_id   = module.compute.alb_zone_id

}