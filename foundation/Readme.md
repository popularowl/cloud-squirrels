# Simple could instance setup with Terraform

This project contains the source code used in Popularowl tutorial - [Building and destroying projects with Terraform](https://www.popularowl.com/cloud-platforms/building-and-destroying-projects-with-terraform)

## How to use this code?

This is [Terraform](https://www.terraform.io) project. It will install and configure a single virtual server on [Digital Ocean](https://m.do.co/c/b61ccd72fd1c) cloud platform (with preintalled Docker CE).

Before running this Terraform project you have to [create public ssh key on Digital Ocean platform](https://www.digitalocean.com/docs/droplets/how-to/add-ssh-keys) and export the value.

You also have to [generate Digital Ocean access token](https://www.digitalocean.com/docs/api/create-personal-access-token) and export it as the environment variable on local machine.

    export TF_VAR_token=xxxxxxxxx
    export TF_VAR_ssh_fingerprint=xxxxxxxxx

## Create & Destroy

After the above setup steps are completed you can use terraform and do the following

    terrafrom init #initialize project & download dependencies
    terraform plan #see what terraform is planning to do
    terraform apply #create and configure the instances
    terraform destroy #destroy all cloud resources

maintained by [@popularowl](https://twitter.com/popularowl)