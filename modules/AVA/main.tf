resource "aws_verifiedaccess_trust_provider" "cognito" {
  policy_reference_name    = "cognitopolicy"
  trust_provider_type      = "user"
  user_trust_provider_type = "oidc"

  oidc_options {
    issuer                 = "https://cognito-idp.us-east-1.amazonaws.com/${var.cognito_user_pool_id}"
    authorization_endpoint = "${var.cognito_domain}/oauth2/authorize"
    token_endpoint         = "${var.cognito_domain}/oauth2/token"
    user_info_endpoint     = "${var.cognito_domain}/oauth2/userInfo"
    client_id              = var.cognito_client_id
    client_secret          = var.cognito_client_secret
    scope                  = "email openid profile"
  }

  tags = {
    Name = "Cognito"
  }
}

