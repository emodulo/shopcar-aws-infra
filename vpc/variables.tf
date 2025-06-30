variable "environment" {
  default = "dev"
}

variable "project" {
  default = "shopcar"
}


variable "vpc" {
  type = object({
    name                     = string
    cidr_block               = string
    internet_gateway_name    = string
    nat_gateway_name         = string
    public_route_table_name  = string
    private_route_table_name = string
    public_subnets = list(object({
      name                    = string
      cidr_block              = string
      availability_zone       = string
      map_public_ip_on_launch = bool
    }))
    private_subnets = list(object({
      name                    = string
      cidr_block              = string
      availability_zone       = string
      map_public_ip_on_launch = bool
    }))
  })

  default = {
    name                     = "shopcar-vpc"
    cidr_block               = "10.0.0.0/24"
    internet_gateway_name    = "shopcar-internet-gateway"
    nat_gateway_name         = "shopcar-nat-gateway"
    public_route_table_name  = "shopcar-public-route-table"
    private_route_table_name = "shopcar-private-route-table"
    public_subnets = [
      {
        name                    = "shopcar-vpc-public-subnet-1a"
        cidr_block              = "10.0.0.0/26"
        availability_zone       = "us-west-1a"
        map_public_ip_on_launch = true
      },
      {
        name                    = "shopcar-vpc-public-subnet-1c"
        cidr_block              = "10.0.0.64/26"
        availability_zone       = "us-west-1c"
        map_public_ip_on_launch = true
      }
    ]
    private_subnets = [
      {
        name                    = "shopcar-vpc-private-subnet-1a"
        cidr_block              = "10.0.0.128/26"
        availability_zone       = "us-west-1a"
        map_public_ip_on_launch = false
      },
      {
        name                    = "shopcar-vpc-private-subnet-1c"
        cidr_block              = "10.0.0.192/26"
        availability_zone       = "us-west-1c"
        map_public_ip_on_launch = false
      }
    ]
  }
}
