resource "google_service_account" "service_account" {
  project      = var.project
  account_id   = var.name
  display_name = var.name
}

resource "google_project_iam_member" "service_account-roles" {
  project = var.project
  role    = var.role
  member  = var.member
}