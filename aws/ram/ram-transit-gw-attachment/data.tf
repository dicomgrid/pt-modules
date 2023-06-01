
# data "aws_ec2_transit_gateway" "main" {
#   provider = aws.first
#   id       = var.tgw_id
# }

# data "aws_subnets" "main" {
#   provider = aws.second

#   filter {
#     name   = "vpc-id"
#     values = [var.vpc_id]
#   }
# }
