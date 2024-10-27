

variable "network_security_group_id`" {
  description = "(Required) The ID of the Network Security Group which should be associated with the Subnet. Changing this forces a new resource to be created."
  type = string
} 
 
variable "subnet_id" {
  description = "(Required) The ID of the Subnet. Changing this forces a new resource to be created."
  type = string
}

variable "location" {
  description = "(Required) The location/region where the virtual network is created."
  type = string
  
}

variable "resource_group_name" {
  description = "(Required) The name of the resource group in which the virtual network is created."
  type = string
}

variable "dns_servers" {
  description = "(Optional) List of IP addresses of DNS servers."
  type = list(string)
  default = []
}

variable "address_space" {
  description = "(Required) List of address spaces to use for the virtual network."
  type = list(string)
}