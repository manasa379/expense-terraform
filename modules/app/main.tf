resource "aws_security_group" "security_group" {
name        = "${var.env}-${var.component}-sg"
description = "${var.env}-${var.component}-sg"
vpc_id      = var.vpc_id

ingress {
  description = "HTTP"
  from_port   = var.app_port
  to_port     = var.app_port
  protocol    = "tcp"
  cidr_blocks = [var.vpc_cidr]
}
ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.bastion_node_cidr
  }
egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
tags = {
  Name = "${var.env}-${var.component}-sg"
}
}
resource "aws_iam_role" "role" {
  name = "${var.env}-${var.component}-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  inline_policy {
    name = "${var.env}-${var.component}-policy"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action   = [
            "ssm:DescribeParameters",
            "ssm:GetParameters",
            "ssm:GetParametersBypath",
            
          ]
          Effect   = "Allow"

          Resource = "*"
        },
      ]
    })
  }
  tags = {
    tag-key = "${var.env}-${var.component}-role"
  }
}
resource "aws_launch_template" "template" {
  name                   = "${var.env}-${var.component}"
  image_id               = data.aws_ami.ami.image_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.security_group.id]

  user_data              = base64encode(templatefile("${path.module}/userdata.sh", {

  }
    "aws_iam_instance_profile"  {
    name = aws_iam_role.role.name
    role_name              = var.component
  }))
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.env}-${var.component}"
    }
  }
}
resource "aws_autoscaling_group" "asg" {
  vpc_zone_identifier = var.subnets
  name                = "${var.env}-${var.component}"
  desired_capacity    = 1
  max_size            = 1
  min_size            = 1

  launch_template {
    id      = aws_launch_template.template.id
    version = "$Latest"
  }
}
