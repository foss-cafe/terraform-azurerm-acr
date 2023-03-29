variable "create_acr" {
  type        = bool
  description = "(Optional) Do you want to create ECR repo"
  default     = true
}

variable "name" {
  type        = string
  description = "(Required) Specifies the name of the Container Registry. Only Alphanumeric characters allowed. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which to create the Container Registry. Changing this forces a new resource to be created."
}

variable "location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable "sku" {
  type        = string
  description = "(Optional) The SKU name of the container registry. Possible values are Basic, Standard and Premium.Defaults to Premium."
  default     = "Premium"
}

variable "admin_enabled" {
  type        = bool
  description = "(Optional) Specifies whether the admin user is enabled. Defaults to false."
  default     = false
}

variable "georeplications" {
  type        = any
  description = <<DESC
  A list of Azure locations where the Ccontainer Registry should be geo-replicated. Only activated on Premium SKU.
  Supported properties are:
    location                  = string
    zone_redundancy_enabled   = bool
    regional_endpoint_enabled = bool
    tags                      = map(string)
  or this can be a list of `string` (each element is a location)
DESC
  default     = []
}

variable "network_rule_set" {
  type        = any
  description = <<DESC
  A list of Azure locations where the Ccontainer Registry should be geo-replicated. Only activated on Premium SKU.
  Supported properties are:
    default_action  = string
    ip_rule         = list(map(string))
    virtual_network = list(map(string))
DESC
  default     = []
}

variable "public_network_access_enabled" {
  type        = bool
  description = "(Optional) Whether public network access is allowed for the container registry. Defaults to true."
  default     = false
}

variable "quarantine_policy_enabled" {
  type        = bool
  description = "(Optional) Boolean value that indicates whether quarantine policy is enabled."
  default     = false
}

variable "retention_policy" {
  type        = any
  description = "(Optional) A retention_policy block"
  default = [
    {
      "days" : 30
      "enabled" : true
    }
  ]
}

variable "trust_policy" {
  type        = any
  description = "(Optional) A trust_policy block "
  default = [
    {
      "enabled" : true
    }
  ]
}

variable "zone_redundancy_enabled" {
  type        = bool
  description = "(Optional) Whether zone redundancy is enabled for this Container Registry? Changing this forces a new resource to be created. Defaults to false."
  default     = false
}

variable "export_policy_enabled" {
  type        = bool
  description = "(Optional) Boolean value that indicates whether export policy is enabled. Defaults to true. In order to set it to false, make sure the public_network_access_enabled is also set to false."
  default     = true
}

variable "identity" {
  type        = any
  description = "(Optional) An identity block"
  default     = []
}

variable "encryption" {
  type        = any
  description = "(Optional) An encryption block"
  default     = []
}

variable "anonymous_pull_enabled" {
  type        = bool
  description = "(Optional) Whether allows anonymous (unauthenticated) pull access to this Container Registry? This is only supported on resources with the Standard or Premium SKU."
  default     = false
}

variable "data_endpoint_enabled" {
  type        = bool
  description = "(Optional) Whether to enable dedicated data endpoints for this Container Registry? This is only supported on resources with the Premium SKU."
  default     = true
}

variable "network_rule_bypass_option" {
  type        = string
  description = "(Optional) Whether to allow trusted Azure services to access a network restricted Container Registry? Possible values are None and AzureServices. Defaults to AzureServices."
  default     = "AzureServices"
}

variable "tags" {
  type        = map(string)
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = {}
}
