resource "aws_cognito_user_pool" "this" {
  name                     = var.user_pool_name
  auto_verified_attributes = ["email"]


  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = false
    name                     = "email"
    required                 = true
  }
  tags = {
    Terraform = "true"
  }
}


resource "aws_cognito_user_pool_client" "this" {
  name            = "${var.user_pool_name}_client"
  user_pool_id    = aws_cognito_user_pool.this.id
  generate_secret = true
  supported_identity_providers = compact([
    "COGNITO",
  ])
  callback_urls                        = ["https://emodulo.com.br/auth/callback/"]
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["code", "implicit"]
  allowed_oauth_scopes                 = ["email", "openid"]
  explicit_auth_flows                  = ["ALLOW_USER_AUTH", ALLOW_USER_SRP_AUTH", "ALLOW_REFRESH_TOKEN_AUTH"]
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
    TCManaged = "true"
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

resource "aws_cognito_user_group" "admin" {
  name         = "admin"
  user_pool_id = aws_cognito_user_pool.this.id
  description  = "Administrator"
}

resource "aws_cognito_user_group" "customer" {
  name         = "customer"
  user_pool_id = aws_cognito_user_pool.this.id
  description  = "Customers"
}

resource "aws_cognito_user" "admin_user" {
  username       = "admin@emodulo.com.br"
  user_pool_id   = aws_cognito_user_pool.this.id
  message_action = "SUPPRESS"
  password       = "TempPass123!"

  attributes = {
    name           = "Admin"
    email          = "admin@emodulo.com.br"
    email_verified = true
  }
}

resource "aws_cognito_user" "customer_user" {
  username       = "customer@emodulo.com.br"
  user_pool_id   = aws_cognito_user_pool.this.id
  message_action = "SUPPRESS"
  password       = "TempPass123!"

  attributes = {
    name           = "Customer"
    email          = "customer@emodulo.com.br"
    email_verified = true
  }
}