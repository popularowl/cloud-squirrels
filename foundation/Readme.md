# Simple VM setup with Terraform

Source code used in Popularowl tutorial about setting up and configuring VMs with Terraform and Digital Ocean.

## How to use this project?

This is [Terraform](https://www.terraform.io) project. It will install and configure a single virtual server on Dogital Ocean.

Before running this Terraform project you have to [create public ssh key on Digital Ocean platform](https://www.digitalocean.com/docs/droplets/how-to/add-ssh-keys) and export the value.

You also have to [generate Digital Ocean access token](https://www.digitalocean.com/docs/api/create-personal-access-token) and export it as environment variable on local machine.

    export TF_VAR_token=xxxxxxxxx
    export TF_VAR_ssh_fingerprint=xxxxxxxxx

## Create & Destroy

After above setup steps are completed you can do the following

    terrafrom init #initialize project & download dependencies
    terraform plan #see what terraform is planning to do
    terraform apply #create and configure the instances
    terraform destroy #destroy all cloud resources

maintained by [@popularowl](https://twitter.com/popularowl)