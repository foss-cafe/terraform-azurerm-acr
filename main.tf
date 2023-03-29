resource "azurerm_container_registry" "this" {
  count = var.create_acr ? 1 : 0

  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  admin_enabled       = var.admin_enabled


  /* georeplications {

  } */
  dynamic "georeplications" {
    for_each = length(var.georeplications) != 0 && var.sku == "Premium" ? var.georeplications : []

    content {
      location                  = try(georeplications.value.location)
      regional_endpoint_enabled = try(georeplications.value.regional_endpoint_enabled, false)
      zone_redundancy_enabled   = try(georeplications.value.zone_redundancy_enabled, false)
      tags                      = try(georeplications.value.tags, {})
    }
  }

  dynamic "network_rule_set" {
    for_each = length(var.network_rule_set) != 0 && var.sku == "Premium" ? var.network_rule_set : []

    content {
      default_action = try(network_rule_set.value.default_action, Allow)

      dynamic "ip_rule" {
        for_each = try(network_rule_set.value.ip_rule, [])

        content {
          action   = "Allow"
          ip_range = try(ip_rule.value.ip_range)
        }
      }

      dynamic "virtual_network" {
        for_each = try(network_rule_set.value.virtual_network, [])

        content {
          action    = "Allow"
          subnet_id = try(virtual_network.value.subnet_id)
        }
      }

    }
  }

  public_network_access_enabled = var.public_network_access_enabled
  quarantine_policy_enabled     = var.quarantine_policy_enabled


  dynamic "retention_policy" {
    for_each = length(var.retention_policy) != 0 ? var.retention_policy : []

    content {
      days    = try(retention_policy.value.days, 7)
      enabled = try(retention_policy.value.enabled, true)
    }

  }

  dynamic "trust_policy" {
    for_each = var.trust_policy

    content {
      enabled = try(trust_policy.value.enabled, true)
    }
  }

  zone_redundancy_enabled = var.zone_redundancy_enabled
  export_policy_enabled   = var.export_policy_enabled


  /* identity {

  }
  encryption {

  } */

  dynamic "identity" {
    for_each = length(var.identity) != 0 ? var.identity : []

    content {
      type         = try(identity.value.type)
      identity_ids = try(identity.value.identity_ids, [])
    }
  }

  dynamic "encryption" {
    for_each = length(var.encryption) != 0 && length(var.identity) != 0 ? var.encryption : []

    content {
      enabled            = try(encryption.value.enabled, true)
      key_vault_key_id   = try(encryption.value.key_vault_key_id)
      identity_client_id = try(encryption.value.identity_client_id)
    }
  }


  anonymous_pull_enabled     = var.anonymous_pull_enabled
  data_endpoint_enabled      = var.data_endpoint_enabled
  network_rule_bypass_option = var.network_rule_bypass_option

  tags = var.tags
}
