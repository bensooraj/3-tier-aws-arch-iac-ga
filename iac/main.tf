module "network" {
  source        = "./modules/network"
  vpc_cidr      = var.vpc_cidr
  all_ipv4_cidr = var.all_ipv4_cidr
}