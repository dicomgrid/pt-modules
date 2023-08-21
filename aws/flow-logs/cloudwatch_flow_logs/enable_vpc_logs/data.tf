
data "aws_vpcs" "selected_vpcs" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}
