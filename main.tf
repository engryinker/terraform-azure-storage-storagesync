resource "azurerm_storage_sync" "this" {
  for_each = var.storage_sync_services

  name                    = each.value.name
  resource_group_name     = var.resource_group_name
  location                = var.location
  incoming_traffic_policy = each.value.incoming_traffic_policy
  tags                    = coalesce(each.value.tags, var.tags)
}

resource "azurerm_storage_sync_group" "this" {
  for_each = var.sync_groups

  name            = each.value.name
  storage_sync_id = azurerm_storage_sync.this[each.value.storage_sync_service_key].id
}
