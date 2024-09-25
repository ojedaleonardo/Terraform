resource "aws_cognito_user_pool" "my_user_pool" {
  name = "MyCognitoUserPool"

  username_attributes = ["email"]

  password_policy {
    minimum_length                   = 8
    require_uppercase                = false
    require_lowercase                = false
    require_numbers                  = false
    require_symbols                  = false
    temporary_password_validity_days = 7
  }

  account_recovery_setting {
    recovery_mechanism {
      priority = 1
      name     = "verified_email"
    }
  }

  email_configuration {
    email_sending_account = "COGNITO_DEFAULT"
  }
}

resource "aws_cognito_user_pool_client" "my_app_client" {
  name                                 = "MyAppClient"
  user_pool_id                         = aws_cognito_user_pool.my_user_pool.id
  explicit_auth_flows                  = ["ALLOW_USER_SRP_AUTH", "ALLOW_CUSTOM_AUTH", "ALLOW_REFRESH_TOKEN_AUTH"]
  callback_urls                        = ["https://ava.tutosleo.online/oauth2/idpresponse"]
  supported_identity_providers         = ["COGNITO"]
  allowed_oauth_flows                  = ["code"]
  allowed_oauth_scopes                 = ["openid", "email", "profile"]
  prevent_user_existence_errors        = "ENABLED"
  allowed_oauth_flows_user_pool_client = true
}

resource "aws_cognito_user_pool_domain" "my_user_pool_domain" {
  domain       = "01071991"
  user_pool_id = aws_cognito_user_pool.my_user_pool.id
}

resource "aws_cognito_user" "leonardo_user" {
  user_pool_id = aws_cognito_user_pool.my_user_pool.id
  username     = "leonardo@tutosleo.online"
  attributes = {
    email          = "leonardo@tutosleo.online"
    email_verified = true
  }

  message_action     = "SUPPRESS"
  temporary_password = "Cl0udH3s1v3"

  lifecycle {
    ignore_changes = [password]
  }
}

resource "aws_cognito_user" "ariel_user" {
  user_pool_id = aws_cognito_user_pool.my_user_pool.id
  username     = "ariel@tutosleo.online"
  attributes = {
    email          = "ariel@tutosleo.online"
    email_verified = false
  }

  message_action     = "SUPPRESS"
  temporary_password = "Cl0udH3s1v3"

  lifecycle {
    ignore_changes = [password]
  }
}
