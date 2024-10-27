resource "azurerm_subnet_network_security_group_association" "snet_nsg_association" {
  subnet_id                 = azurerm_subnet.example.id
  network_security_group_id = azurerm_network_security_group.example.id
}