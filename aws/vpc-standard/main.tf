resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = var.tenancy
  
  enable_dns_hostnames = var.dns_hostnames
  enable_dns_support = var.dns_support
 
  tags = {
    Name = ""
    Environment = var.Environment
    Owner = var.Owner
    Creator = var.Creator
    
  }
}

resource "aws_eip" "eip_natgw" {
  vpc      = true
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = ""
    Environment = "development" 
    Owner = "Platform" 
    Creator = "Terraform"
}
}


resource "aws_route_table_association" "a" {
  count = length(aws_subnet.public_subnets)
  subnet_id      = element(aws_subnet.public_subnets[*].id,count.index)
  route_table_id = aws_route_table.igw_rt.id
}

locals {
  availability_zone_names = "${data.aws_availability_zones.availability_zones.names}"
  max_subnets = 2
}

resource "aws_subnet" "public_subnets" {
  vpc_id = "${aws_vpc.main.id}"
  count = "${length(local.availability_zone_names)}"
  cidr_block = "${cidrsubnet(aws_vpc.main.cidr_block, 4, count.index)}"
  availability_zone = "${local.availability_zone_names[count.index]}"
  map_public_ip_on_launch = var.public_ip_on_launch
  tags = {
    Name = "public.${local.availability_zone_names[count.index]}"
    Environment = var.Environment
    Owner = var.Owner
    Creator = var.Creator
  }
}
resource "aws_subnet" "private_subnets" {
  vpc_id = "${aws_vpc.main.id}"
  count = "${length(local.availability_zone_names)}"
  cidr_block = "${cidrsubnet(aws_vpc.main.cidr_block, 4, count.index+2)}"
  availability_zone = "${local.availability_zone_names[count.index]}"
  map_public_ip_on_launch = false

  tags = {
    Name = "private.${local.availability_zone_names[count.index]}"
    Environment = var.Environment
    Owner = var.Owner
    Creator = var.Creator
  }
}
resource "aws_route_table" "igw_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "igw_rt_primary"
    Environment = var.Environment
    Owner = var.Owner
    Creator = var.Creator
  }
}


resource "aws_nat_gateway" "natgw_default" {
  allocation_id = aws_eip.eip_natgw.id
  subnet_id     = aws_subnet.private_subnets[0].id
    tags = {
    Name = "nat-gw primary"
  }
   depends_on = [aws_internet_gateway.igw]
}