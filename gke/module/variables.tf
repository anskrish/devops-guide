variable "credentials" {
  type        = string
  description = "Location of the credential keyfile."
  default = "./terraform-gkecluster-keyfile.json"
}

variable "project_id" {
  type        = string
  description = "The project ID to create the cluster."
  default = "testsrnadim"
}

variable "cluster_name" {
  type = string
  default = "krishna-sandbox"
}

variable "location" {
  type = string
}

variable "node_count" {}

variable "tags" {
 type  = list(string)
}

