variable "resource_group_name" {
  description = "The name of resource group"
  type        = string
  default     = "terraform_02"
}

variable "resource_location" {
  description = "location of the resources"
  type        = string
  default     = "westeurope"
}

variable "vm_size" {
  description = "SKU of virtual machine"
  type        = string
  default     = "Standard_B1s"
}

# following variables are not used in the example, are here only for documentation.
variable "number_example" {
  description = "An example of a number variable in Terraform"
  type        = number
  default     = 42
}

variable "list_example" {
  description = "An example of a list in Terraform"
  type        = list
  default     = ["a", "b", "c"]
}

variable "list_numeric_example" {
  description = "An example of a numeric list in Terraform"
  type        = list(number)
  default     = [1, 2, 3]
}

variable "map_example" {
  description = "An example of a map in Terraform"
  type        = map(string)

  default = {
    key1 = "value1"
    key2 = "value2"
    key3 = "value3"
  }
}

variable "object_example" {
  description = "An example of a structural type in Terraform"
  type        = object({
    name    = string
    age     = number
    tags    = list(string)
    enabled = bool
  })

  default = {
    name    = "value1"
    age     = 42
    tags    = ["a", "b", "c"]
    enabled = true
  }
}
