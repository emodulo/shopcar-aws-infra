resource "aws_cognito_user_pool" "this" {
  name = var.user_pool_name

  username_attributes      = ["email"]
  auto_verified_attributes = ["email"]
  alias_attributes         = ["email"]

  schema = [
    {
      name     = "email"
      required = true
      attribute_data_type = "String"
      mutable  = true
    },
    {
      name     = "name"
      required = true
      attribute_data_type = "String"
      mutable  = true
    }
  ]

  tags = {
    Terraform = "true"
  }
}

resource "aws_cognito_user_pool_client" "this" {
  name            = "${var.user_pool_name}_client"
  user_pool_id    = aws_cognito_user_pool.this.id
  generate_secret = true

  supported_identity_providers = ["COGNITO"]

  callback_urls                        = ["https://oauth.pstmn.io/v1/callback"]
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["code"]
  allowed_oauth_scopes                 = ["email", "openid", "profile"]
  explicit_auth_flows                  = [
    "ALLOW_USER_SRP_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH"
  ]
}

resource "aws_cognito_identity_pool" "this" {
  identity_pool_name               = "${var.user_pool_name}_identity"
  allow_unauthenticated_identities = false

  cognito_identity_providers {
    client_id               = aws_cognito_user_pool_client.this.id
    provider_name           = aws_cognito_user_pool.this.endpoint
    server_side_token_check = false
  }

  tags = {
    Terraform = "true"
  }
}

resource "aws_cognito_identity_pool_provider_principal_tag" "this" {
  identity_pool_id       = aws_cognito_identity_pool.this.id
  identity_provider_name = aws_cognito_user_pool.this.endpoint
  use_defaults           = false

  principal_tags = {
    test = "value"
  }
}

resource "aws_cognito_user_pool_domain" "this" {
  domain       = var.user_pool_name
  user_pool_id = aws_cognito_user_pool.this.id
}
