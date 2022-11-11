resource "aws_vpc" "main" {
  cidr_block       = var.vpc_range
  instance_tenancy = var.tenancy

  enable_dns_hostnames = var.dns_hostnames
  enable_dns_support = var.dns_support
  tags = {
    Name = "$(Owner)_vpc"
    Environment = var.Environment
    Owner = var.Owner
    Creator = var.Creator
    
  }
}


locals {availability_zone_names = "${data.aws_availability_zones.availability_zones.names}"}
resource "aws_subnet" "public_subnets" {
  vpc_id = "${aws_vpc.main.id}"
  count = length(data.aws_availability_zones.availability_zones.names) < 3 ? length(data.aws_availability_zones.availability_zones.names) : 2
  cidr_block = "${cidrsubnet(aws_vpc.main.cidr_block, 2, count.index)}"
  availability_zone = "${local.availability_zone_names[count.index]}"
  map_public_ip_on_launch = true
  tags = {
    Name = "public.${local.availability_zone_names[count.index]}"
    Environment = var.Environment
    Owner = var.Owner
    Creator = var.Creator
  }
}

resource "aws_subnet" "private_subnets" {
  vpc_id = "${aws_vpc.main.id}"
  count = length(data.aws_availability_zones.availability_zones.names) < 3 ? length(data.aws_availability_zones.availability_zones.names) : 2
  cidr_block = "${cidrsubnet(aws_vpc.main.cidr_block, 2, count.index)}"
  availability_zone = "${local.availability_zone_names[count.index]}"

  map_public_ip_on_launch = false
    tags = {
    Name = "private.${local.availability_zone_names[count.index]}"
    Environment = var.Environment
    Owner = var.Owner
    Creator = var.Creator
  }
  }

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = ""
    Environment = "Development" 
    Owner = "Platform" 
    Creator = "Terraform"
}
}
resource "aws_route_table" "igw_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "$(Owner)_rt"
    Environment = var.Environment
    Owner = var.Owner
    Creator = var.Creator
  }
}
resource "aws_route_table_association" "a" {
  count = length(aws_subnet.public_subnets)
  subnet_id      = element(aws_subnet.public_subnets[*].id,count.index)
  route_table_id = aws_route_table.igw_rt.id
}

resource "aws_eip" "nat_gateway" {
  vpc = true
}

##SDtill need to finish nat gw
/*resource "aws_subnet" "nat_gateway" {
  availability_zone = data.aws_availability_zones.availablility_zone.names[0]
  cidr_block = element(aws_subnet.public_subnets,0)
  vpc_id = aws_vpc.main.id
  tags = {
    "Name" = "natgw_subet"
  }
}*/




/*esource "aws_route_table" "instance" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
}
resource "aws_route_table_association" "instance" {
  subnet_id = aws_subnet.private_subnets[0].id
  route_table_id = aws_route_table.instance.id*/
