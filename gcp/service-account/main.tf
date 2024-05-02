resource "google_service_account" "service_account" {
  project      = var.project
  account_id   = var.name
  display_name = var.name
}
