# Provider version
terraform {
  required_version = "~> 1.2.7"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.34.0"
    }
  }
}

# Provider Configuration
provider "google" {
    project     = var.project
    region      = var.region
    zone        = var.zone
    credentials = file("credentials/credentials.json")
  
}