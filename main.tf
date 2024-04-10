module "vpc" {
  source                 = "./modules/vpc"
  vpc_cidr               = var.vpc_cidr
  env                    = var.env
  public_subnets         = var.public_subnets
  private_subnets        = var.private_subnets
  azs                    = var.azs
  default_vpc_id         = var.default_vpc_id
  default_vpc_cidr       = var.default_vpc_cidr
  default_route_table_id = var.default_route_table_id
  account_no             = var.account_no
}

module "public-lb" {
  source = "./modules/alb"
  alb_type = "public"
  env      = var.env
  internal = false
  subnets  = module.vpc.public_subnets
  vpc_id   = module.vpc.vpc_id
  alb_sg_allow_cidr = "0.0.0.0/0"
}