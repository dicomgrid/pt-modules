output "subnet_ids" {
  value = [for az_subnets in local.subnets_by_az : az_subnets[0]]
}

output "vpc_id" {
  value = data.aws_vpc.main.id
}