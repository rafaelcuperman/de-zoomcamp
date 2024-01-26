terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.13.0"
    }
  }
}

provider "google" {
  credentials = "/Users/rafaelcuperman/Documents/Personal/de-zoomcamp/keys/de-zoomcamp-rc-0191d40db8f1.json"
  project = "de-zoomcamp-rc"
  region  = "us-central1"
}

resource "google_storage_bucket" "demo-bucket" {
  name          = "de-zoomcamp-rc-terra-bucket"
  location      = "US"
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}