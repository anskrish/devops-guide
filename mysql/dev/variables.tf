variable "project_id" {
  type        = string
  default = "testsrnadim"
  description = "The project to run tests against"
}

variable "network_name" {
  default = "default"
  type    = string
}

variable "db_name" {
  description = "The name of the SQL Database instance"
  default     = "example-mysql-private"
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
