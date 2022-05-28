terraform {
  backend "gcs" {
    credentials = "./test.json"
    bucket      = "terraform-store-kri577"
    prefix      = "unit/dev/terraform/sql/"
  }
}

locals {
    cwd  = reverse(split("/", path.cwd))
    location = local.cwd[0]
    environment = local.cwd[1]
}


module "mssql" {
  source               = "../../tfm/sql"
  name                 = var.name
  random_instance_name = true
  project_id           = var.project_id
  user_name            = "belktest"
  user_password        = "belkrootadmin87983"

  deletion_protection = false
}
