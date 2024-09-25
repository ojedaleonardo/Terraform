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

