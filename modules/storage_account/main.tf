resource "azurerm_storage_account" "sa-backend" {
    name                              = "sabackendcn3"
    resource_group_name               = var.sig_resource_group.name
    location                          = var.location
    account_kind                      = "StorageV2"
    account_tier                      = "Standard"
    account_replication_type          = "GZRS"
    cross_tenant_replication_enabled  = false
    access_tier                       = "Cool"
    https_traffic_only_enabled        = true
    min_tls_version                   = "TLS1_2"
    allow_nested_items_to_be_public   = false
    shared_access_key_enabled         = false
    public_network_access_enabled     = false
    default_to_oauth_authentication   = true
    is_hns_enabled                    = false
    nfsv3_enabled                     = false
    large_file_share_enabled          = true
    local_user_enabled                = false
    infrastructure_encryption_enabled = true
    queue_encryption_key_type         = "Account"
    table_encryption_key_type         = "Account"
    allowed_copy_scope                = "AAD"
    sftp_enabled                      = false
    dns_endpoint_type                 = "Standard"

    blob_properties {
        versioning_enabled            = true
        change_feed_enabled           = true
        change_feed_retention_in_days = 15
        last_access_time_enabled      = true

        delete_retention_policy {
        days = 15
        }

        restore_policy {
        days = 14
        }

        container_delete_retention_policy {
        days = 14
        }
    }

    network_rules {
        default_action             = "Deny"
        bypass                     = ["AzureServices", "Logging", "Metrics"]
        ip_rules                   = []
        virtual_network_subnet_ids = []
    }
}

resource "azurerm_storage_container" "container-backend" {
    name                  = "state"
    storage_account_id    = azurerm_storage_account.sa-backend.id
    container_access_type = "private"
}

resource "azurerm_storage_container" "container-backend-backup" {
    name                  = "state-backup"
    storage_account_id    = azurerm_storage_account.sa-backend.id
    container_access_type = "private"
}



