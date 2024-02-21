variable "credentials" {
  description = "My Credentials"
  default     = "../../../keys/my-creds.json"
}

variable "project" {
  description = "Project"
  default     = "de-zoomcamp-rc"
}

variable "region" {
  description = "Region"
  default     = "central1"
}

variable "location" {
  description = "Project Location"
  default     = "US"
}

variable "gcs_bucket_name" {
  description = "My Storage Bucket Name"
  default     = "de-zoomcamp-rc-homework-3"
}
