terraform {
  required_providers {
    google = {
      version = "3.84.0"
    }
  }
  backend "gcs" {
    credentials = "./terraform-gkecluster-keyfile.json"
    bucket      = "terraform-store-kri577"
    prefix      = "unit/terraform/state/terrafor.tfstate"
  }
}
