variable "resource_group_name" {
  description = "The name of resource group"
  type        = string
  default     = "terraform_state"
}

variable "resource_location" {
  description = "location of the resources"
  type        = string
  default     = "westeurope"
}

variable "storage_name" {
  description = "name of storage"
  type        = string
  default     = "terrademoalk" # you need to change this, it must be unique
}