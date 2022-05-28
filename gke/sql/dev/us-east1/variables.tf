variable "project_id" {
  type        = string
  description = "The project to run tests against"
  default = "testsrnadim"
}

variable "name" {
  type        = string
  description = "The name for Cloud SQL instance"
  default     = "best-mssql-public"
}

variable "region" {
  default = "us-east1"
  type    = string
}

variable "credentials_file_path" {
  type        = string
  description = "The name for Cloud SQL instance"
  default     = "./test.json"
}
