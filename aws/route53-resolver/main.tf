module "endpoint_info" {
  source = "../common/vpc-subnet-id-per-az-lookup"

  subnets_filter = var.subnets_filter
  vpc_name       = var.vpc_name
}

module "security_group" {
  source = "../security-group"

  description = lookup(var.security_group, "description", null)
  vpc_name    = var.vpc_name
  ingress     = var.security_group.ingress
  egress      = try(var.security_group.egress, var.egress_default)
  tags        = merge(var.tags, lookup(var.security_group, "tags", {}), { Name = "${var.endpoint_name}-sg" })
}

module "resolver" {
  source = "./resolver"

  endpoint_name      = var.endpoint_name
  direction          = var.direction
  rules              = try(var.rules, {})
  security_group_ids = [module.security_group.id]
  subnet_ids         = module.endpoint_info.subnet_ids
  vpc_id             = module.endpoint_info.vpc_id
  tags               = merge(var.tags, { Name = var.endpoint_name })
}