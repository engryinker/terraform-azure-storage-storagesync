output "storage_sync_services" {
  description = "Map (same keys as var.storage_sync_services) of the created azurerm_storage_sync resources."
  value       = azurerm_storage_sync.this
}

output "sync_groups" {
  description = "Map (same keys as var.sync_groups) of the created azurerm_storage_sync_group resources."
  value       = azurerm_storage_sync_group.this
}
