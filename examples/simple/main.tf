module "acr" {
  source              = "../../"
  name                = "iba6yu5bgopi"
  resource_group_name = "terraform-test"
  location            = "East US"
  sku                 = "Premium"
  admin_enabled       = true
}
