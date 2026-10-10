variable "resource_group_name" {
  description = "Name of the existing resource group to deploy every resource in this module call into. This module does not create the resource group itself."
  type        = string
}

variable "location" {
  description = "Azure region for every resource created by this module call."
  type        = string
}

variable "tags" {
  description = "Default tags applied to every resource created by this module call (e.g. the output of terraform-azure-tags). Overridden per-resource by that resource's own `tags` attribute, if set."
  type        = map(string)
  default     = {}
}

variable "storage_sync_services" {
  description = <<-EOT
    Map of Azure File Sync (Storage Sync Service) resources to create, keyed by an arbitrary caller-chosen map key.

    NOTE: there is no published AVM module for Azure File Sync as of this writing, so this wraps the native
    `azurerm_storage_sync` / `azurerm_storage_sync_group` resources directly. Swap in an AVM module if/when
    Microsoft publishes one.
    https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_sync
  EOT
  type = map(object({
    name                    = string
    incoming_traffic_policy = optional(string, null)
    tags                    = optional(map(string))
  }))
  default = {}
}

variable "sync_groups" {
  description = <<-EOT
    Map of Storage Sync groups to create, keyed by an arbitrary caller-chosen map key.
    `storage_sync_service_key` must reference a key in var.storage_sync_services.
    https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_sync_group
  EOT
  type = map(object({
    name                     = string
    storage_sync_service_key = string
  }))
  default = {}
}
