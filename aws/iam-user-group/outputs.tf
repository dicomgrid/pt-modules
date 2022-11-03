output "aws_iam_group_names" {
  value = values(aws_iam_group.main)[*].name
}