env = "dev"
vpc_cidr               = "10.0.0.0/16"
public_subnets         = ["10.0.0.0/24", "10.0.1.0/24"]
private_subnets        = ["10.0.2.0/24", "10.0.3.0/24"]
azs                    = ["us-east-1a", "us-east-1b"]
default_vpc_id         = "vpc-072cba722d1b81096"
default_vpc_cidr       = "172.31.0.0/16"
account_no             = "212103609741"
default_route_table_id = "rtb-0c93a6419777be65f"
bastion_node_cidr      =  ["172.31.39.218/32"]
desired_capacity       =  1
max_size               =  1
min_size               =  1
instance_class         =  "db.t3.medium"
prometheus_cidr        =  ["172.31.1.246/32"]