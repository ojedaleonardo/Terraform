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

resource "aws_verifiedaccess_group" "VAG" {
  depends_on                 = [aws_verifiedaccess_instance_trust_provider_attachment.VAI_Attachment]
  description                = "Grupo de Verified Access para Cognito"
  verifiedaccess_instance_id = aws_verifiedaccess_instance.VAI.id
  policy_document            = var.email_policy

  tags = {
    Name = "VAG"
  }
}

resource "aws_verifiedaccess_endpoint" "VAP" {
  application_domain     = "ava.tutosleo.online"
  attachment_type        = "vpc"
  description            = "Punto de conexion Verified Access"
  domain_certificate_arn = "arn:aws:acm:us-east-1:059140706790:certificate/a305792a-a92c-435e-900e-13ba8059f2d4"
  endpoint_domain_prefix = "ava"
  endpoint_type          = "load-balancer"
  load_balancer_options {
    load_balancer_arn = var.load_balancer_arn
    port              = 80
    protocol          = "http"
    subnet_ids        = [var.private_subnet_a_id, var.private_subnet_b_id]
  }
  verified_access_group_id = aws_verifiedaccess_group.VAG.id
  security_group_ids       = [var.default_security_group_id]

  tags = {
    Name = "VAP"
  }

  timeouts {
    create = "60m"
    delete = "60m"
  }
}

resource "aws_route53_record" "ava_cname" {
  depends_on = [aws_verifiedaccess_endpoint.VAP]
  zone_id    = var.zone_id
  name       = "ava"
  type       = "CNAME"
  ttl        = 300
  records    = [aws_verifiedaccess_endpoint.VAP.endpoint_domain]
}







