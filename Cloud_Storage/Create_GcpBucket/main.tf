resource "google_storage_bucket" "test" {
  name          = var.bucket_name
  location      = var.region
  storage_class = var.bucket_class

  force_destroy               = true
  uniform_bucket_level_access = true
  # public_access_prevention = "enforced"
  versioning {
    enabled = false
  }

  lifecycle_rule {
    condition {
      #days
      age = 3
    }
    action {
      type = "Delete"
    }
  }

  retention_policy {
    is_locked        = false
    retention_period = 259200 #seconds
  }

}
