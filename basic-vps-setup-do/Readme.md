# Simple could instance setup with Terraform

This example ilustrates how to provision a basic virtual private server on DigitalOcean cloud platform. This source code also used in tutorial on Popularowl site - [Building and destroying projects with Terraform](https://www.popularowl.com/cloud-platforms/building-and-destroying-projects-with-terraform).

## How to use this code

This is a [Terraform](https://www.terraform.io) project. You need to have Terraform (>= 1.9.7) [installed](https://learn.hashicorp.com/tutorials/terraform/install-cli).

Once you run this project with Terraform it will setup and configure a single VPS server (droplet) on your [Digital Ocean](https://m.do.co/c/b61ccd72fd1c) cloud platform. After setup is finished VPS will also have preinstalled Docker environment.

Before running this Terraform project you have to [upload your public ssh key to Digital Ocean platform](https://www.digitalocean.com/docs/droplets/how-to/add-ssh-keys) and get its fingerprint.

You also have to [generate Digital Ocean access token](https://www.digitalocean.com/docs/api/create-personal-access-token). Export both of these values as the environment variables on your local machine.

    export TF_VAR_token=xxxxxxxxx
    export TF_VAR_ssh_fingerprint=xxxxxxxxx

Step by step guide on [Popularowl site](https://www.popularowl.com/cloud-platforms/building-and-destroying-projects-with-terraform).

## Create & Destroy

After the above setup steps are completed you all all set to use terraform and do the following

    terraform init #initialize project & download dependencies
    terraform plan #see what terraform is planning to do
    terraform apply -auto-approve #create and configure the instances
    terraform destroy #destroy all cloud resources
