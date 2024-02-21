variable "credentials" {
  description = "My Credentials"
  default     = "../../keys/my-creds.json"
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

variable "bq_dataset_name" {
  description = "BQ dataset"
  default     = "nyc_tlc"
}

variable "gcs_bucket_name" {
  description = "GCS Bucket"
  default     = "nyc-tlc"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}
