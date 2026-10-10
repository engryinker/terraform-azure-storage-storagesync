terraform {
  required_version = ">= 1.7.0"
}

module "storagesync" {
  source = "../.."

  resource_group_name = "rg-example"
  location            = "eastus"
  tags = {
    environment = "dev"
  }

  storage_sync_services = {} # see README Inputs table for the per-entry schema
  sync_groups           = {}
}
