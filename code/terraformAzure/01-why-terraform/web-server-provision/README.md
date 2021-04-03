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
# First generate a private / public RSA key pair to access the virtual machine

# This is the sample cose with the output, **leave password blank and call the key .\my-key** 
ssh-keygen.exe -b 4096 
Generating public/private rsa key pair.
Enter file in which to save the key (C:\Users\alkam/.ssh/id_rsa): .\my-key
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in .\my-key.
Your public key has been saved in .\my-key.pub.

# Now you can perform init with terraform
terraform init
terraform plan -out testplan
terraform apply testplan
```

If you need to retrieve data for public IP you can use this code.

```PowerShell
$ipAddress = terraform output -json ip_address | ConvertFrom-json
# you can output ip address
$ipAddress.ip_address

# If you want to use SSH in windows to connect to the machine 
ssh "azureuser@$($ipAddress.ip_address)" -i .\my-key
```

Clean up when you're done:

```
terraform destroy
```

Gian Maria