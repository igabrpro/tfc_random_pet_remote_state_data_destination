# tfc_random_pet_remote_state_data_destination

This is the destination repo for [tfc_random_pet_remote_state_data_source](https://github.com/igabrpro/tfc_random_pet_remote_state_data_source.git) they must be used together. So this one can use the output from the source.

[source repo](https://github.com/igabrpro/tfc_random_pet_remote_state_data_source.git)

## Requirements
You will need to have TFC account and VCS

## Repo content 
```main.tf``` - Terraform configuration file

## Guide
1. First you need to have the source repo up and runninf in TFC
2. Upload this one in new workspace
3. The workspace of the source needs to be needs to be shared with this one 
4. Steps to share 
    - navigate to ```app.terraform.io/app/<organization name>/workspaces/<workspace name>/settings/general```
    - in general settings navigate to ```Remote state sharing``` and add the destination workspace using the ```Share with specific workspaces```  option 

## How the code works

```
data "terraform_remote_state" "pet" {
  backend = "remote"

  config = {
    organization = "ivan_test"
    workspaces = {
      name = "random_pet_source"
    }
  }
}


resource "null_resource" "pet" {
 provisioner "local-exec" {
    command = "echo ${data.terraform_remote_state.pet.outputs.pet_name}"
  }
}
```

The data module here is using the remote state data source to get the output information form the ```tfc_random_pet_remote_state_data_source``` backend is remote as we are using TFC, the organization name must be the name of your organization and the workspace the name of the workspace thet your destination code is located.

The output just prints the name of the pet resource from the source workspace 
the command ```command = "echo ${data.terraform_remote_state.pet.outputs.pet_name}"``` works as follows:
```data.terraform_remote_state.pet``` is the data thet is gathered from the soure workspace 
```outputs.pet_name``` is the string that is outputed at the pet_name resource, if oyu don't add this you will get JSON output of all data 


