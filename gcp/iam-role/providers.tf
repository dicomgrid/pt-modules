terraform {
  required_version = ">= 1.0.9"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.66.0"
    }
  }
}