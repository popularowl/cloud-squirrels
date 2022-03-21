#
# Terraform variables referenced by other terraform
# files in this project
#

# token should be exported in the local
# shell environment to avoid hardcoded values
# see readme.md for examples
variable "token" {
  description = "Digital Ocean Api Token"
}

variable "region" {
  description = "Digital Ocean Region"
  default = "lon1"
}
variable "droplet_image" {
  description = "Digital Ocean Droplet Image Name"
  default = "debian-11-x64"
}

variable "droplet_size" {
  description = "Droplet size"
  default = "s-1vcpu-1gb"
}

# location of the private ssh key 
# used for ssh connection by terraform
# change the location if different on 
# your local machine
variable "pvt_sshkey" {
  description = "Location of the local private ssh key"
  default = "~/.ssh/id_rsa"
}

# ssh_key_fingerprint variable placeholder
# it should be exported as local env variable
# see readme.md for examples
variable "ssh_key_fingerprint" {
  description = "Fingerprint of the public ssh key stored on Digital Ocean"
}