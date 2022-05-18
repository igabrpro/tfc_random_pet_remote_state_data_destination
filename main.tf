terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "3.1.1"
    }
  }
}

provider "null" {}


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
