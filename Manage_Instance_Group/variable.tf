variable "region" {
  description = "value of Region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "value of zone"
  type        = string
  default     = "us-central1-a"
}

variable ""instance-template-tf"" {
  description = "Name of Instance Template"
  type        = string
  default     = "test1"
}

variable "machine_type" {
  description = "value of machine_type"
  type        = string
  default     = "e2-medium"
  
}

variable "autohealing_health_check" {
  description = "value of Autohealing Health Check"
  type        = string
  default     = "autohealing-health-check"
}

variable "instance_group_manager" {
  description = "value of Instance Group Manager"
  type        = string
  default     = "instance-group-manager-test1"
}

variable "autoscaler" {
  description = "value of Autoscaler"
  type        = string
  default     = "autoscaler-test1"
}