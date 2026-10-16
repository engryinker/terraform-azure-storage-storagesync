# terraform-azure-storage-storagesync

Org-standard Terraform wrapper for **Azure File Sync** (Storage Sync Service + Sync Groups).

⚠️ **No AVM module exists for this resource** as of this writing. This wraps the native `azurerm_storage_sync` / `azurerm_storage_sync_group` resources directly, following the same conventions as the rest of this org's module set. Swap it for an AVM module if/when Microsoft publishes one.

Deploys into an existing resource group -- this module does not create the resource group itself. Compose with [terraform-azure-naming](https://github.com/engryinker/terraform-azure-naming) and [terraform-azure-tags](https://github.com/engryinker/terraform-azure-tags).

## Usage

```hcl
module "storagesync" {
  source = "git::https://github.com/engryinker/terraform-azure-storage-storagesync.git?ref=v1.0.0"

  resource_group_name = azurerm_resource_group.this.name
  location             = azurerm_resource_group.this.location
  tags                 = module.tags.tags

  storage_sync_services = {
    main = { name = "storagesync-prod-eus" }
  }

  sync_groups = {
    group1 = {
      name                     = "syncgroup-app1"
      storage_sync_service_key = "main"
    }
  }
}
```

See [`examples/basic`](examples/basic) for a minimal (zero-instance) example.

## Inputs

### `storage_sync_services`

| Field | Type | Required | Notes |
| --- | --- | --- | --- |
| `name` | `string` | yes | |
| `incoming_traffic_policy` | `string` | no | |
| `tags` | `map(string)` | no | |

### `sync_groups`

| Field | Type | Required | Notes |
| --- | --- | --- | --- |
| `name` | `string` | yes | |
| `storage_sync_service_key` | `string` | yes | Must reference a key in `var.storage_sync_services`. |

## Outputs

- `storage_sync_services` -- map of created `azurerm_storage_sync` resources.
- `sync_groups` -- map of created `azurerm_storage_sync_group` resources.
