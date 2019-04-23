# Automated Jenkins setup with Docker and Terraform

This is source code used for Jenkins tutorials on [Popularowl](https://www.popularowl.com).

* [Installing, configuring and running JenkinsCI server](https://www.popularowl.com/blog/installing-configuring-jenkinsci-nginx)
* [Automating Jenkins install and configuration with Docker and Terraform](https://www.popularowl.com/jenkins/automating-jenkins-install-docker-terraform)
* [Jenkins plugins and plugin management](https://www.popularowl.com/jenkins/jenkins-plugins-and-plugin-management)

## How to use

Before running the Terraform script you have to [setup ssh keys on Digital Ocean platform](https://www.digitalocean.com/docs/droplets/how-to/add-ssh-keys) and export the values

    export TF_VAR_token=xxxxxxxxx
    export TF_VAR_ssh_fingerprint=xxxxxxxxx
    terraform apply

maintained by [@popularowl](https://twitter.com/popularowl)