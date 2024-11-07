#
# main Terraform file
# to describe automation steps
#

# configure the DigitalOcean Provider
# with required security token
provider "digitalocean" {
  token = var.token
}

# create VM instance on Digital Ocean
resource "digitalocean_droplet" "popularowl-server" {
    image = var.droplet_image
    name = "popularowl-server"
    region = var.region
    size = var.droplet_size
    ssh_keys = [
        var.ssh_key_fingerprint
    ]

    # allow Terrform to connect via ssh
    connection {
        host        = self.ipv4_address
        user        = "root"
        type        = "ssh"
        private_key = "${file(var.pvt_sshkey)}"
        timeout     = "2m"
    }

    # copy the files
    provisioner "file" {
        source      = "files/kong.conf"
        destination = "/tmp/kong.conf"
    }

    provisioner "file" {
        source      = "files/setup.sh"
        destination = "/tmp/setup.sh"
    }
 
    provisioner "file" {
        source      = "files/provision_apis.sh"
        destination = "/tmp/provision_apis.sh"
    }

    # run all necessary commands via remote shell 
    provisioner "remote-exec" {
        inline = [
            # update & install dependencies
            "apt-get update",
            "chmod 755 /tmp/setup.sh",
            "/tmp/setup.sh",
            # provision test api resource
            "chmod 755 /tmp/provision_apis.sh",
            "/tmp/provision_apis.sh"   
        ]
    }
}

# print out ip address of created VM server
output "service-ip" {
  value = "your new instance is running with IP address: ${digitalocean_droplet.popularowl-server.ipv4_address}"
}