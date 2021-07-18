provider "aws" {
  region = local.region
}
locals {
  name   = "dev"
  region = "us-west-2"
  tags = {
    Owner = "krishna.rudraraju"
    Environment = "dev"
  }
}

module "dev" {
  source = "../../../modules/vpc/."
  create_vpc = true
  vpc_name = local.name
  vpc_cidr = "10.2.0.0/20"
  enable_dns_hostnames = true
  enable_dns_support = true

  azs = ["${local.region}a", "${local.region}b", "${local.region}c"]
  public_subnets  = ["10.2.2.0/24", "10.2.3.0/24"]
  private_subnets = ["10.2.0.0/24", "10.2.1.0/24"]
  enable_nat_gateway = true 
  single_nat_gateway = true
  enable_peer_with_vpn = false
  vpn_peer_id = "vpc-xxxxx"
  vpn_peer_cidr = "10.1.0.0/24"
  vpn_peering_tag = "VPN"
  enable_peer_with_systems = false
  systems_peer_id = "vpc-xxxx"
  systems_peer_cidr = "10.3.0.0/20"
  systems_peering_tag = "SYSTEMS-Dev"
  tags = local.tags
  public_subnet_tags = {
    Name = "Dev-public-subnet"
  }
}

