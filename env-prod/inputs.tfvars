env = "prod"

vpc_cidr               = "10.255.0.0/16"
public_subnets         = ["10.255.0.0/24", "10.255.1.0/24"]
private_subnets        = ["10.255.2.0/24", "10.255.3.0/24"]
azs                    = ["us-east-1a", "us-east-1b"]
default_vpc_id         = "vpc-072cba722d1b81096"
default_vpc_cidr       = "172.31.0.0/16"
account_no             = "212103609741"
default_route_table_id = "rtb-0c93a6419777be65f"
bastion_node_cidr      =  ["172.31.39.218/32"]
desired_capacity       =  2
max_size               =  10
min_size               =  2
instance_class         = "db.t3.medium"
prometheus_cidr        =  ["172.31.1.246/32"]