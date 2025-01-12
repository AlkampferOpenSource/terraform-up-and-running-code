# Terraform "Hello, World" example

This folder contains a "Hello, World" example of a [Terraform](https://www.terraform.io/) configuration. The configuration deploys a single resource group in an [Azure account](http://portal.azure.com/).

For more info, please see the preface of *[Terraform: Up and Running](http://www.terraformupandrunning.com)*.

## Pre-requisites

* You must have [Terraform](https://www.terraform.io/) installed on your computer. 
* You must have an [Azure Account](http://portal.azure.com/).

Please note that this code was written for Terraform 0.12.x.

## Quick start

Please follow instruction to [setup terraform for your azure account](https://docs.microsoft.com/en-gb/azure/developer/terraform/get-started-cloud-shell)

To login and select subscription:

```
az login
az account list --query "[].{name:name, subscriptionId:id}"
az account set --subscription="<subscription_id>"
```

Deploy the code:

```
terraform init
terraform apply
```

Ok now you have a couple of nice output variables, one is the ip address of the machine

```PowerShell
$ipAddress = terraform output -json ip_address | ConvertFrom-json
# you can output ip address
$ipAddress.ip_address

# Now you can dump private key of the machine into a file.
terraform output -raw tls_private_key > machine.key

# Now change permission to key file or ssh cannot use it

# remove inheritance
Icacls machine.key /c /t /Inheritance:d

# Add current user as owner
$currentUser = whoami
Icacls machine.key /c /t /Grant "$currentUser`:F"

# Remove other standard users
Icacls machine.key /c /t /Remove Administrator "Authenticated Users" BUILTIN\Administrators BUILTIN Everyone System Users

# Finally connect in ssh
ssh "azureuser@$($ipAddress.ip_address)" -i .\machine.key
```

Clean up when you're done:

```
terraform destroy
```