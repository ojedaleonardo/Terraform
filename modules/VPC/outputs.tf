output "vpc_id" {
  value = aws_vpc.Test-VPC.id
}

output "private_subnet_a_id" {
  value = aws_subnet.Private-A.id
}

output "private_subnet_b_id" {
  value = aws_subnet.Private-B.id
}

output "public_subnet_a_id" {
  value = aws_subnet.Public-A.id
}

output "public_subnet_b_id" {
  value = aws_subnet.Public-B.id
}

# output "redis_subnet_group_id" {
#   value = aws_elasticache_subnet_group.Private-Redis.id
# }

output "natgw_id" {
  value = aws_nat_gateway.NATGW.id
}

output "default_security_group_id" {
  value = aws_security_group.Test-VPC.id
}
