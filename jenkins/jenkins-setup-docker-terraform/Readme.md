# Automated Jenkins setup with Docker and Terraform

Source code in this repository is used for set of Jenkins CI tutorials on [Popularowl](https://www.popularowl.com).

* [Installing, configuring and running JenkinsCI server](https://www.popularowl.com/blog/installing-configuring-jenkinsci-nginx)
* [Automating Jenkins install and configuration with Docker and Terraform](https://www.popularowl.com/jenkins/automating-jenkins-install-docker-terraform)
* [Jenkins plugins and plugin management](https://www.popularowl.com/jenkins/jenkins-plugins-and-plugin-management)

## How to use

There are 2 ways you can use this infrastructure as a code project.

### Build Docker image

You can just build Docker image from the provided Dockerfile and run Docker container locally.

    cd files
    docker build -t popularowl/jenkins .
    docker run -d --name jenkins-server -p 8080:8080 popularowl/jenkins

### Use Terraform to build VPS with Jenkins container

This is [Terraform](https://www.terraform.io) project. It will install, configure and prepare Jenkins server for your continuous integration flow.

Before running the Terraform script you have to first [setup ssh keys on Digital Ocean platform](https://www.digitalocean.com/docs/droplets/how-to/add-ssh-keys) and export the values.

    export TF_VAR_token=xxxxxxxxx
    export TF_VAR_ssh_key_fingerprint=xxxxxxxxx
    terraform init 
    terraform plan 
    terraform apply -auto-approve
    terraform destroy
