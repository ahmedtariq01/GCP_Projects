variable "region" {
  description = "value of Region"
  type        = string
  default     = "us-central1"
}

variable "bucket_name" {
  description = "value of Bucket Name"
  type        = string
  default     = "test-bucket-1"
}
variable "bucket_class" {
  description = "value of Bucket Class"
  type        = string
  default     = "STANDARD"
}
