 locals {
  iam_role_arn = coalesce(
    data.aws_iam_role.existing_role.arn,  # Use the existing role if found
    aws_iam_role.new_role[0].arn          # Otherwise, use the newly created role
  )
} 