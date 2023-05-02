resource "aws_directory_service_directory" "main" {
  name        = var.name
  short_name  = var.short_name
  description = var.description
  password    = var.password
  edition     = var.edition
  type        = var.type

  vpc_settings {
    vpc_id     = data.aws_vpc.main.id
    subnet_ids = data.aws_subnets.main.ids
  }

  tags = local.tags
}