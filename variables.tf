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
  description = "CIDR Subnet Privada B"
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

variable "ec2_linux_specs" {
  description = "Parametros de instancia Linux"
  type        = map(string)
}

variable "ec2_windows_specs" {
  description = "Parametros de instancia Windows"
  type        = map(string)
}

variable "ec2_aws_specs" {
  description = "Parametros de instancia AWS Linux 2023"
  type        = map(string)
}

variable "kms_key_id" {
  type = string
}
