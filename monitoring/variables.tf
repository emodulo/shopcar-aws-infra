variable "environment" {
  default = "dev"
}

variable "project" {
    default = "shopcar"

}

variable "SOURCE_GMAIL_ID"{
  description = "Source GMAIl Id"
  default = "emodulo@gmail.com"
}
variable "SOURCE_AUTH_PASSWORD"{
  description = "Source Auth Password"
  default ="gerarpassword"
}
variable "DESTINATION_GMAIL_ID"{
  description = ""
  default ="kj.juniorzinho@gmail.com"
}

variable "domain_name" {
  default = "emodulo.com.br"
}

variable "allow_ip" {
  default = ["0.0.0.0/0"]
}