# Terraform Site example

Help for terraform on azure can be found [in official msdn]( https://learn.microsoft.com/en-gb/azure/developer/terraform/).

## Pre-requisites

- You must have [Terraform](https://www.terraform.io/) installed on your computer. 
- You must have an [Azure Account](http://portal.azure.com/).
- You must have Azure CLI installed (can install with *winget install microsoft.azurecli*)
Please note that this code was written for Terraform 0.12.x.

## Quick start

Please follow instruction to [setup terraform for your azure account](https://docs.microsoft.com/en-gb/azure/developer/terraform/get-started-cloud-shell)

To login and select subscription:

```
az login
az account list --query "[].{name:name, subscriptionId:id}"
az account set --subscription="<subscription_id>"
```

## Create resource on azure with Terraform

Here is the sequence of commands you need to run *to create resources on azure*. Please not forget to specify rg_name to specify resource group name

```
terraform init
terraform plan -out testplan -var 'rg_name=Terra_test' -var 'keycloak_client_secret=xxxxx'
terraform apply testplan
```

Clean up when you're done:

```
terraform destroy
```

Gian Maria