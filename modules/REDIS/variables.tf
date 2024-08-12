# variable "redis_vpc_id" {
#   description = "Nombre del VPC de Redis"
#   type        = string
# }

variable "redis_subnet_group_id" {
  description = "ID del Subnet Group de Redis"
  type        = string
}

variable "redis_security_group_id" {
  description = "Security Group de Redis"
  type        = string
}
