terraform {
  required_version = ">= 1.9.7"
  
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.43.0"
    }
  }
}
