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