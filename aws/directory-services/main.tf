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

  tags = {
    Application = var.application
    Billing     = var.billing
    Creator     = var.creator
    Environment = var.environment
    Name        = var.name
    Owner       = var.owner
  }
}