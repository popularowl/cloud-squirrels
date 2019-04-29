#
# main Terraform file to describe automation
#

# choose Digital Ocean provider
provider "digitalocean" {
  token = "${var.token}"
}

# create VM instance on Digital Ocean
# this instance will host Jenkins master and Nginx reverse proxy
resource "digitalocean_droplet" "kong-api-gateway" {
    image = "${var.droplet_image}"
    name = "kong-api-gateway"
    region = "${var.region}"
    size = "${var.droplet_size}"
    ssh_keys = [
        "${var.ssh_fingerprint}"
    ]

    // allow Terrform to connect via ssh
    connection {
        user = "root"
        type = "ssh"
        private_key = "${file(var.pvt_sshkey)}"
        timeout = "2m"
    }

    # // copy the files
    provisioner "file" {
        source      = "files/kong.conf"
        destination = "/tmp/kong.conf"
    }

    provisioner "file" {
        source      = "files/setup.sh"
        destination = "/tmp/setup.sh"
    }

    // run all necessary commands via remote shell 
    provisioner "remote-exec" {
        inline = [
            # update & install dependencies
            "apt-get update",
            "chmod 755 /tmp/setup.sh",
            "/tmp/setup.sh"
        ]
    }
}

# print out ip address of created VM server
output "service-ip" {
  value = "${digitalocean_droplet.kong-api-gateway.ipv4_address}"
}