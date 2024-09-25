variable "cognito_user_pool_id" {
  description = "The User Pool ID from Cognito"
  type        = string
}

variable "cognito_domain" {
  description = "The domain for the Cognito User Pool"
  type        = string
}

variable "cognito_client_id" {
  description = "The Client ID for the Cognito App Client"
  type        = string
}

variable "cognito_client_secret" {
  description = "The Client Secret for the Cognito App Client"
  type        = string
}
