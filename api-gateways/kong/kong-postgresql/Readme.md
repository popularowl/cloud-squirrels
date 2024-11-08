# Automated Kong API Gateway setup with Terraform

The source code in this repository is used for Kong API Gateway tutorials on [Popularowl](https://www.popularowl.com/api-gateway-tutorials/).

* [Automating Kong API gateway setup](https://www.popularowl.com/blog/automating-kong-api-gateway-automating-setup/)

## How to use

This is [Terraform](https://www.terraform.io) project. It automates install, configure and setup Kong API Gateway for your platform projects and proof of concepts.

Terraform is using [Digital Ocean](https://m.do.co/c/b61ccd72fd1c) cloud platform to provision a single VPS server.

Prerequisites. [Setup ssh keys on the Digital Ocean platform](https://www.digitalocean.com/docs/droplets/how-to/add-ssh-keys). Export key values in the shell environment where you run Terraform (see below)

    export TF_VAR_token=xxxxxxxxx
    export TF_VAR_ssh_key_fingerprint==xxxxxxxxx

## Create & Destroy

After the above setup steps are completed you all all set to use Terraform and do the following

    terraform init #initialize project & download dependencies
    terraform plan #see what Terraform is planning to do
    terraform apply -auto-approve #create and configure the instances
    terraform destroy -auto-approve #destroy all cloud resources

maintained by [@popularowl](https://twitter.com/popularowl)
