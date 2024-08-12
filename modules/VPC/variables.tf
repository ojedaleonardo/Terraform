variable "vpc_cidr" {
  description = "CIDR VPC"
  type        = string
}

variable "vpc_name" {
  description = "Nombre del VPC"
  type        = string
}

variable "private_a_cidr" {
  description = "CIDR Subnet Privada A"
  type        = string
}

variable "private_b_cidr" {
  description = "CIDR Subnet Privada A"
  type        = string
}


variable "public_a_cidr" {
  description = "CIDR Subnet Publica A"
  type        = string
}

variable "public_b_cidr" {
  description = "CIDR Subnet Publica B"
  type        = string
}
