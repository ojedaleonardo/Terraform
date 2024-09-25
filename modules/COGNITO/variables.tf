variable "user_pool_name" {
  description = "Nombre del User Pool de Cognito"
  type        = string
  default     = "MyCognitoUserPool"
}

variable "app_client_name" {
  description = "Nombre del App Client"
  type        = string
  default     = "MyAppClient"
}
