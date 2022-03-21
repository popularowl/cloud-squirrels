terraform {
  required_version = ">= 1.1.5"
  
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}