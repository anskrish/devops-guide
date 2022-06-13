terraform {
  required_providers {
    google = {
      version = "3.84.0"
    }
  }
  backend "gcs" {
    credentials = "./test.json"
    bucket      = "terraform-store-kri577"
    prefix      = "unit/dev/terraform/mysql/"
  }
}

locals {
    cwd  = reverse(split("/", path.cwd))
    location = local.cwd[0]
    environment = local.cwd[1]
}

resource "random_id" "suffix" {
  byte_length = 5
}

locals {
  network_name = "${var.network_name}-safer-${random_id.suffix.hex}"
}

module "private_mysql" {
  source               = "../module/private_mysql/."
  name                 = var.db_name
  random_instance_name = true
  project_id           = var.project_id

  deletion_protection = false

  database_version = "MYSQL_5_6"
  region           = "us-east1"
  zone             = "us-east1-c"
  tier             = "db-n1-standard-1"

  // By default, all users will be permitted to connect only via the
  // Cloud SQL proxy.
  additional_users = [
    {
      name     = "app"
      password = "PaSsWoRd"
      host     = "localhost"
      type     = "BUILT_IN"
    },
    {
      name     = "readonly"
      password = "PaSsWoRd"
      host     = "localhost"
      type     = "BUILT_IN"
    },
  ]

  assign_public_ip   = "true"
#  vpc_network        = module.network-safer-mysql-simple.network_self_link
#  allocated_ip_range = module.private-service-access.google_compute_global_address_name

  // Optional: used to enforce ordering in the creation of resources.
}
