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

## Storage example

You need first to create a suitable storage for the state, running the terraform blob storage creation main.tf at global\blobstorage directory. This will create a Storage Account and inside that storage account a blob to store terraform state.

Once you created the state you can simply run the example in stage\data-stores\sql-server that creates a nice sql server database using 
state manager created in step 1. In this example you need to populate data by yourself based on how you created 
the Storage Account in previous step