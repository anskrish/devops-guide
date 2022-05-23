variable "project_id" {
  type        = string
  description = "The project ID to create the cluster."
  default = "testsrnadim"
}

variable "region" {
  type        = string
  description = "The region to create the cluster."
  default = "us-west3"
}
variable "credentials" {
  type        = string
  description = "Location of the credential keyfile."
  default = "./terraform-gkecluster-keyfile.json"
}
