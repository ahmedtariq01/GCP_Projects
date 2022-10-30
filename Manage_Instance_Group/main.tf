# Creating an Instance Template
resource "google_compute_instance_template" "instance_template_tf" {
  name           = var.instance-template-tf
  machine_type   = var.machine_type
  region         = var.region
  can_ip_forward = false
  disk {
    source_image = "debian-cloud/debian-11"
    auto_delete  = true
    boot         = true
  }
  network_interface {
    network = "default"
    access_config {
      // Ephemeral public IP
    }
  }
  lifecycle {
    create_before_destroy = true
  }
  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  metadata_startup_script = file("script.sh")

  service_account {
    scopes = ["cloud-platform"]
  }
  tags = ["http-server", "https-server"]
}

# Creating a firewall rule
resource "google_compute_firewall" "allow_http" {
  project = var.project
  name    = "allow-http-rule"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "1000-2000"]
  }
  target_tags   = ["http-server", "https-server"]
  source_ranges = ["0.0.0.0/0"]
  # priority      = 1000
}

# Creating autohealing health check for the instance group
resource "google_compute_health_check" "autohealing" {
  name                = var.autohealing_health_check
  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 10 # 50 seconds

  http_health_check {
    request_path = "/"
    port         = "80"
  }
}

# Creating an Instance Group Manager
resource "google_compute_instance_group_manager" "instance_group_manager_tf" {
  name               = var.instance_group_manager
  zone               = var.zone
  base_instance_name = "instance-group-tf"
  version {
    name              = var.instance-template-tf
    instance_template = google_compute_instance_template.instance_template_tf.id
  }
  named_port {
    name = "web"
    port = 80
  }

  auto_healing_policies {
    health_check      = google_compute_health_check.autohealing.id
    initial_delay_sec = 50
  }

}

# Creating an Autoscaler for the instance group
resource "google_compute_autoscaler" "default" {
  name   = var.autoscaler
  zone   = var.zone
  target = google_compute_instance_group_manager.instance_group_manager_tf.id
  autoscaling_policy {
    min_replicas    = 2
    max_replicas    = 3
    cooldown_period = 60
  }
}

