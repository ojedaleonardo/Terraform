resource "aws_vpc" "Test-VPC" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "Private-A" {
  vpc_id            = aws_vpc.Test-VPC.id
  cidr_block        = var.private_a_cidr
  availability_zone = "us-east-1a"
  tags = {
    Name = "${var.vpc_name}-Private-A"
  }
}

resource "aws_route_table" "Private-rtb" {
  vpc_id = aws_vpc.Test-VPC.id
  tags = {
    Name = "${var.vpc_name}-Private-rtb"
  }
}

resource "aws_route_table_association" "Private-A-rtb" {
  subnet_id      = aws_subnet.Private-A.id
  route_table_id = aws_route_table.Private-rtb.id
}

resource "aws_route" "Private-rtb" {
  depends_on             = [aws_nat_gateway.NATGW]
  route_table_id         = aws_route_table.Private-rtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.NATGW.id
}

resource "aws_subnet" "Private-B" {
  vpc_id            = aws_vpc.Test-VPC.id
  cidr_block        = var.private_b_cidr
  availability_zone = "us-east-1b"
  tags = {
    Name = "${var.vpc_name}-Private-B"
  }
}

resource "aws_route_table_association" "Private-B-rtb" {
  subnet_id      = aws_subnet.Private-B.id
  route_table_id = aws_route_table.Private-rtb.id
}

resource "aws_subnet" "Public-A" {
  vpc_id            = aws_vpc.Test-VPC.id
  cidr_block        = var.public_a_cidr
  availability_zone = "us-east-1a"
  tags = {
    Name = "${var.vpc_name}-Public-A"
  }
}

resource "aws_route_table" "Public-rtb" {
  vpc_id = aws_vpc.Test-VPC.id
  tags = {
    Name = "${var.vpc_name}-Public-rtb"
  }
}

resource "aws_route_table_association" "Public-A-rtb" {
  subnet_id      = aws_subnet.Public-A.id
  route_table_id = aws_route_table.Public-rtb.id
}

resource "aws_route" "Public-A-rtb" {
  depends_on             = [aws_internet_gateway.IGW]
  route_table_id         = aws_route_table.Public-rtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.IGW.id
}

resource "aws_subnet" "Public-B" {
  vpc_id            = aws_vpc.Test-VPC.id
  cidr_block        = var.public_b_cidr
  availability_zone = "us-east-1b"
  tags = {
    Name = "${var.vpc_name}-Public-B"
  }
}

resource "aws_route_table_association" "Public-B-rtb" {
  subnet_id      = aws_subnet.Public-B.id
  route_table_id = aws_route_table.Public-rtb.id
}

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.Test-VPC.id
  tags = {
    Name = "${var.vpc_name}-IGW"
  }
}

resource "aws_eip" "EIP" {
  domain = "vpc"
  tags = {
    Name = "${var.vpc_name}-EIP"
  }
}

resource "aws_nat_gateway" "NATGW" {
  allocation_id = aws_eip.EIP.id
  subnet_id     = aws_subnet.Public-A.id
  tags = {
    Name = "${var.vpc_name}-NATGW"
  }
}

# resource "aws_elasticache_subnet_group" "Private-Redis" {
#   name       = "Redis"
#   subnet_ids = [aws_subnet.Private-A.id, aws_subnet.Private-B.id]
# }

