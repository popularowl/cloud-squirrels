# Automated Kong Api Gateway setup with Terraform

Source code in this repository is used for Kong Api Gateway tutorials on [Popularowl](https://www.popularowl.com).

* [Automating Kong api gateway setup](https://www.popularowl.com/api-first/automating-kong-api-gateway-automating-setup/)

## How to use

This is [Terraform](https://www.terraform.io) project. It will install, configure and prepare Kong Api Gateway for your platform projects and proof of concepts.

Before running the Terraform script you have to first [setup ssh keys on Digital Ocean platform](https://www.digitalocean.com/docs/droplets/how-to/add-ssh-keys) and export the values.

    export TF_VAR_token=xxxxxxxxx
    export TF_VAR_ssh_fingerprint=xxxxxxxxx
    terraform apply

maintained by [@popularowl](https://twitter.com/popularowl)