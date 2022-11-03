output "aws_iam_group_names" {
  value = {for k, v in aws_iam_group.main: k => v.name}
}