resource "aws_verifiedaccess_trust_provider" "cognito" {
  description              = "Proveedor de Confianza Cognito"
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

resource "aws_verifiedaccess_instance" "VAI" {
  depends_on  = [aws_verifiedaccess_trust_provider.cognito]
  description = "Instancia de Verified Access"

  tags = {
    Name = "VAI"
  }
}

resource "aws_verifiedaccess_instance_trust_provider_attachment" "VAI_Attachment" {
  depends_on                       = [aws_verifiedaccess_instance.VAI]
  verifiedaccess_instance_id       = aws_verifiedaccess_instance.VAI.id
  verifiedaccess_trust_provider_id = aws_verifiedaccess_trust_provider.cognito.id
}


