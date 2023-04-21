locals {
    account_role_arns = {
        cloudpacs = [
        "arn:aws:iam::581514789096:role/cross_account_storage_prod",
        "arn:aws:iam::337731736347:role/cross_account_pacs_test",
        "arn:aws:iam::337731736347:role/cross_account_pacs_test_jenkins",
        "arn:aws:iam::038161360085:role/cross_account_staging",
        ],
        cloudinfra = [
        "arn:aws:iam::442576575068:role/cross_account_cloud_infra_jenkins",
        "arn:aws:iam::431872258017:role/cross_account_cloudinfra_prod_jenkins",
        "arn:aws:iam::371313213563:role/cross_account_cloudinfra_staging_jenkins",
        ]
        iws = [
        "arn:aws:iam::554076900781:role/cross_account_dev",
        "arn:aws:iam::383458647736:role/cross_account_staging",
        "arn:aws:iam::614945970796:role/cross_account_prod",
        "arn:aws:iam::554076900781:role/cross_account_jenkins",
        "arn:aws:iam::383458647736:role/cross_account_jenkins",
        "arn:aws:iam::614945970796:role/cross_account_jenkins",
        ]
        clario = [
        "arn:aws:iam::615821722087:role/clario-cloud-dev",
        ]
  }
}