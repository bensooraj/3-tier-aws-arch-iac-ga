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

  # Subnet IDs
  web_subnet_ids  = module.network.web_subnet_ids
  app_subnet_ids  = module.network.app_subnet_ids
  data_subnet_ids = module.network.data_subnet_ids

  # Bastion Host
  bastion_host_ami_id        = var.bastion_host_ami_id
  bastion_host_instance_type = var.bastion_host_instance_type
  bastion_host_sg_id         = module.network.bastion_host_sg_id
}
