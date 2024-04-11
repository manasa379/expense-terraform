resource "aws_security_group" "security_group" {
  name        = "${var.env}-${var.alb_type}-sg"
  description = "${var.env}-${var.alb_type}-sg"
  vpc_id      = var.vpc_id
}
tags = {
  Name = "${var.env}-${var.alb_type}-sg"
}

resource "aws_vpc_security_group_ingress_rule" "security_group"  {
  security_group_id = aws_security_group.security_group.id
  cidr_blocks       =  [var.alb_sg_allow_cidr]
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}
resource "aws_vpc_security_group_egress_rule" "security_group" {
  security_group_id = aws_security_group.security_group.id
  cidr_blocks       = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_lb" "alb_type" {
  name               = "${var.env}-${var.alb_type}"
  internal           = var.internal
  load_balancer_type = "application"
  security_groups    = [aws_security_group.security_group.id]
  subnets            = var.subnets

  tags = {
    Environment = "${var.env}-${var.alb_type}"
  }
}