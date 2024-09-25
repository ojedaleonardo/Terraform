output "user_pool_id" {
  value = aws_cognito_user_pool.my_user_pool.id
}

output "user_pool_client_id" {
  value = aws_cognito_user_pool_client.my_app_client.id
}

output "user_pool_client_secret" {
  value = aws_cognito_user_pool_client.my_app_client.client_secret
}

output "cognito_domain" {
  value = aws_cognito_user_pool_domain.my_user_pool_domain.domain
}
