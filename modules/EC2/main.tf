# resource "aws_instance" "Windows" {
#   ami                    = var.ec2_windows_specs.ami
#   instance_type          = var.ec2_windows_specs.instance_type
#   subnet_id              = var.private_subnet_a_id
#   vpc_security_group_ids = [aws_security_group.SG-Windows.id]
#   iam_instance_profile   = "SSM"
#   key_name               = data.aws_key_pair.Windows.key_name

#   root_block_device {
#     volume_type = "gp3"
#     volume_size = 30
#   }

#   tags = {
#     Name         = "Windows"
#     PatchManager = "Testing"
#   }
# }

# resource "aws_security_group" "SG-Windows" {
#   name        = "SG-Windows"
#   description = "Allow RDP inbound traffic"
#   vpc_id      = var.vpc_id

#   ingress {
#     from_port   = 3389
#     to_port     = 3389
#     protocol    = "tcp"
#     cidr_blocks = ["10.0.0.0/8"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

data "template_file" "redis_cli" {
  template = file("${path.module}/redis_cli.sh")
}

locals {
  instance_name = "Ubuntu"
}

resource "aws_instance" "Ubuntu" {
  depends_on             = [var.natgw_id]
  ami                    = var.ec2_linux_specs.ami
  instance_type          = var.ec2_linux_specs.instance_type
  subnet_id              = var.private_subnet_b_id
  vpc_security_group_ids = [aws_security_group.SG-Linux.id]
  iam_instance_profile   = "SSM"
  key_name               = data.aws_key_pair.Linux.key_name
  user_data              = data.template_file.redis_cli.rendered

  root_block_device {
    volume_type = "gp3"
    volume_size = 8

    tags = {
      Name = "${local.instance_name}-EBS"
    }
  }

  tags = {
    Name         = local.instance_name
    PatchManager = "Testing"
  }
}

output "instance_id" {
  value = aws_instance.Ubuntu.id
}

resource "aws_security_group" "SG-Linux" {
  name        = "SG-Linux"
  description = "Allow SSH inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb" "NLB-AVA" {
  name                       = "NLB-AVA"
  internal                   = true
  load_balancer_type         = "network"
  subnets                    = [var.private_subnet_a_id, var.private_subnet_b_id]
  enable_deletion_protection = false
}

resource "aws_lb_target_group" "TG-NGINX" {
  name        = "TG-NGINX"
  port        = 80
  protocol    = "TCP"
  vpc_id      = var.vpc_id
  target_type = "instance"
}

resource "aws_lb_target_group_attachment" "TG-Attachment" {
  target_group_arn = aws_lb_target_group.TG-NGINX.arn
  target_id        = aws_instance.Ubuntu.id
  port             = 80
}

resource "aws_lb_listener" "LISTENER-NGINX" {
  load_balancer_arn = aws_lb.NLB-AVA.arn
  port              = 80
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.TG-NGINX.arn
  }
}

# resource "aws_security_group" "SG-Redis" {
#   name        = "SG-Redis"
#   description = "Allow Redis Inbound traffic"
#   vpc_id      = var.vpc_id
#   tags = {
#     Name = "SG-Redis"
#   }

#   ingress = [
#     {
#       from_port        = 6379
#       to_port          = 6379
#       protocol         = "tcp"
#       cidr_blocks      = ["172.16.0.0/16"]
#       ipv6_cidr_blocks = []
#       prefix_list_ids  = []
#       security_groups  = []
#       self             = false
#       description      = "Inbound Rule"
#     }
#   ]

#   egress = [
#     {
#       from_port        = 0
#       to_port          = 0
#       protocol         = "-1"
#       cidr_blocks      = ["0.0.0.0/0"]
#       ipv6_cidr_blocks = []
#       prefix_list_ids  = []
#       security_groups  = []
#       self             = false
#       description      = "Outbound rule"
#     }
#   ]
# }

# resource "aws_instance" "AWS" {
#   depends_on             = [var.natgw_id]
#   ami                    = var.ec2_aws_specs.ami
#   instance_type          = var.ec2_aws_specs.instance_type
#   subnet_id              = var.private_subnet_b_id
#   vpc_security_group_ids = [aws_security_group.SG-AWS.id]
#   iam_instance_profile   = "SSM"
#   key_name               = data.aws_key_pair.Linux.key_name

#   tags = {
#     Name         = "AWS"
#     PatchManager = "Testing"
#   }
# }

# resource "aws_security_group" "SG-AWS" {
#   name        = "SG-AWS"
#   description = "Allow SSH inbound traffic"
#   vpc_id      = var.vpc_id

#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["10.0.0.0/8"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }
