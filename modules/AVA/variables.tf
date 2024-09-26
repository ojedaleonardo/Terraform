variable "cognito_user_pool_id" {
  description = "The ID of the Cognito User Pool"
  type        = string
}

variable "cognito_domain" {
  description = "The domain for the Cognito User Pool"
  type        = string
}

variable "cognito_client_id" {
  description = "The Client ID of the Cognito User Pool Client"
  type        = string
}

variable "cognito_client_secret" {
  description = "The Client Secret of the Cognito User Pool Client"
  type        = string
}

variable "email_policy" {
  description = "The policy document that is associated with this resource"
  type        = string
  default     = <<-EOT
permit (principal,action,resource)
when {
	context.cognitopolicy.email_verified == "true"
};
EOT
}

variable "private_subnet_a_id" {
  description = "ID de la subred privada A"
  type        = string
}

variable "private_subnet_b_id" {
  description = "ID de la subred privada B"
  type        = string
}

variable "load_balancer_arn" {
  description = "ARN del Network Load Balancer"
  type        = string
}

variable "default_security_group_id" {
  description = "ID del Security Group por defecto"
  type        = string
}
