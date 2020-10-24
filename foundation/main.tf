#
# main Terraform file
# to describe automation steps
#

# choose Digital Ocean provider
provider "digitalocean" {
  token = "${var.token}"
}

# create VM instance on Digital Ocean
resource "digitalocean_droplet" "popularowl-server" {
    image = "${var.droplet_image}"
    name = "popularowl-server"
    region = "${var.region}"
    size = "${var.droplet_size}"
    ssh_keys = [
        "${var.ssh_key_fingerprint}"
    ]

    # allow Terrform to connect via ssh
    connection {
        user = "root"
        type = "ssh"
        private_key = "${file(var.pvt_sshkey)}"
        timeout = "2m"
    }

    # copy the files
    provisioner "file" {
        source      = "files/setup.sh"
        destination = "/tmp/setup.sh"
    }

    # run all necessary commands via secure shell 
    provisioner "remote-exec" {
        inline = [
            # run setup script
            "chmod 755 /tmp/setup.sh",
            "/tmp/setup.sh"
        ]
    }
}

# print out ip address of created Jenkins server VM
output "service-ip" {
  value = "your new instance is prepared and running with external IP address: ${digitalocean_droplet.popularowl-server.ipv4_address}"
}