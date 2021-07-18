####vpn peering####

resource "aws_vpc_peering_connection" "vpn-peering" {
  count = var.create_vpc && var.enable_peer_with_vpn ? 1 : 0
  peer_vpc_id   = var.vpn_peer_id
  vpc_id        = local.vpc_id
  auto_accept   = true
  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }
  tags = {
    Name = var.vpn_peering_tag
  }
}

resource "aws_route" "peering_private_route_vpn" {
  count = var.create_vpc && var.enable_peer_with_vpn && length(var.private_subnets) > 0 ? 1 : 0
  route_table_id         = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = var.vpn_peer_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.vpn-peering[count.index].id

  timeouts {
    create = "5m"
  }
}

resource "aws_route" "peering_public_route_vpn" {
  count = var.create_vpc && var.enable_peer_with_vpn ? 1 : 0
  route_table_id         = element(aws_route_table.public.*.id, count.index)
  destination_cidr_block = var.vpn_peer_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.vpn-peering[count.index].id

  timeouts {
    create = "5m"
  }
}

resource "aws_route_table_association" "private_peering" {
  count = var.create_vpc && var.enable_peer_with_vpn ? 1 : 0
  subnet_id = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private[count.index].id
}

resource "aws_route_table_association" "public_peering" {
  count = var.create_vpc && var.enable_peer_with_vpn ? 1 : 0
  subnet_id = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public[count.index].id
}


####Systems peering####

resource "aws_vpc_peering_connection" "systems-peering" {
  count = var.create_vpc && var.enable_peer_with_systems ? 1 : 0
  peer_vpc_id   = var.systems_peer_id
  vpc_id        = local.vpc_id
  auto_accept   = true
  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }
  tags = {
    Name = var.systems_peering_tag
  }
}

resource "aws_route" "peering_private_route_systems" {
  count = var.create_vpc && var.enable_peer_with_systems && length(var.private_subnets) > 0 ? 1 : 0
  route_table_id         = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = var.systems_peer_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.systems-peering[count.index].id

  timeouts {
    create = "5m"
  }
}

resource "aws_route" "peering_public_route_systems" {
  count = var.create_vpc && var.enable_peer_with_systems ? 1 : 0
  route_table_id         = element(aws_route_table.public.*.id, count.index)
  destination_cidr_block = var.systems_peer_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.systems-peering[count.index].id

  timeouts {
    create = "5m"
  }
}

resource "aws_route_table_association" "systems_private_peering" {
  count = var.create_vpc && var.enable_peer_with_systems && length(var.private_subnets) > 0 ? 1 : 0
  subnet_id = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private[count.index].id
}

resource "aws_route_table_association" "systems_public_peering" {
  count = var.create_vpc && var.enable_peer_with_systems ? 1 : 0
  subnet_id = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public[count.index].id
}
