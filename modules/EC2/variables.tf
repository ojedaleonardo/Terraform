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

variable "private_subnet_a_id" {
  description = "ID de la subred privada A"
  type        = string
}

variable "private_subnet_b_id" {
  description = "ID de la subred privada B"
  type        = string
}

variable "vpc_id" {
  description = "Nombre del VPC"
  type        = string
}

variable "natgw_id" {
  description = "Nombre del NATGW"
  type        = string
}

