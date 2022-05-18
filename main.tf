data "terraform_remote_state" "pet" {
  backend = "remote"

  config = {
    organization = "ivan_test"
    workspaces = {
      name = "random_pet_source"
    }
  }
}

output  "value"{
  value = data.terraform_remote_state.pet
}
