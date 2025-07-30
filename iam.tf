
module "trustgrid_iam" {
  source = "../../aws/iam-role"

  name = local.iam_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
##
  inline_policies = {
    route_management = {
      name = "${local.iam_role_name}-route-policy"
      policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Effect = "Allow"
            Action = [
              "ec2:DescribeRouteTables"
            ]
            Resource = "*"
          },
          {
            Effect = "Allow"
            Action = [
              "ec2:CreateRoute",
              "ec2:DeleteRoute"
            ]
            Resource = [
              for rt_id in local.unique_route_table_ids :
              "arn:aws:ec2:${module.foundation.account_info.region}:${module.foundation.account_info.account_id}:route-table/${rt_id}"
            ]
          }
        ]
      })
    }
    ec2_basic = {
      name = "${local.iam_role_name}-ec2-policy"
      policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Effect = "Allow"
            Action = [
              "ec2:DescribeInstances",
              "ec2:DescribeInstanceStatus",
              "ec2:DescribeNetworkInterfaces",
              "ec2:DescribeSecurityGroups",
              "ec2:DescribeSubnets",
              "ec2:DescribeVpcs"
            ]
            Resource = "*"
          }
        ]
      })
    }
  }

  instance_profiles = {
    main = {
      name = local.iam_profile_name
    }
  }

  tags = module.foundation.tags
}