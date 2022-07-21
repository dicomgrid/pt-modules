locals {
  scp          = flatten([for scp in var.ou-scp : [for policy-name, policy-content in scp.policies : { name = policy-name, content = policy-content }]])
  scp-policies = { for e in local.scp : e.name => e }
  full-list    = setproduct([for e in keys(local.org-env) : e], [for p in local.scp-policies : p.name])
}

resource "aws_organizations_policy" "org-policy" {
  for_each = local.scp-policies
  content  = each.value.content
  name     = each.value.name
}

# Attach the SCP to a particular OU, we can probably separate it out
resource "aws_organizations_policy_attachment" "org-policy-attach" {
  count     = length(local.full-list)
  policy_id = aws_organizations_policy.org-policy[local.full-list[count.index][1]].id
  target_id = aws_organizations_organizational_unit.org[local.full-list[count.index][0]].id
}