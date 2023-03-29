output "id" {
  description = "The ID of the Container Registry."
  value       = try(azurerm_container_registry.this[0].id, "")
}

output "login_server" {
  description = "The URL that can be used to log into the container registry."
  value       = try(azurerm_container_registry.this[0].login_server, "")
}

output "admin_username" {
  description = "The Username associated with the Container Registry Admin account - if the admin account is enabled."
  value       = try(azurerm_container_registry.this[0].admin_username, "")
}

output "admin_password" {
  description = "The Password associated with the Container Registry Admin account - if the admin account is enabled."
  value       = try(azurerm_container_registry.this[0].admin_password, "")
}
