#
# main Terraform file to describe automation
#

# choose Digital Ocean provider
provider "digitalocean" {
  token = "${var.token}"
}

# create VM instance on Digital Ocean
# this instance will host Jenkins master and Nginx reverse proxy
resource "digitalocean_droplet" "jenkinsci-server" {
    image = var.droplet_image
    name = "jenkinsci-server"
    region = var.region
    size = var.droplet_size
    ssh_keys = [
        var.ssh_key_fingerprint
    ]

    // allow Terrform to connect via ssh
    connection {
        host        = self.ipv4_address
        user        = "root"
        type        = "ssh"
        private_key = "${file(var.pvt_sshkey)}"
        timeout     = "2m"
    }

    // copy all the required files 
    // to the newly created instance
    provisioner "file" {
        source      = "files/jenkins-proxy"
        destination = "/tmp/jenkins-proxy"
    }

    provisioner "file" {
        source      = "files/Dockerfile"
        destination = "/tmp/Dockerfile"
    }

    provisioner "file" {
        source      = "files/jenkins-plugins"
        destination = "/tmp/jenkins-plugins"
    }

    provisioner "file" {
        source      = "files/default-user.groovy"
        destination = "/tmp/default-user.groovy"
    }

    provisioner "file" {
        source      = "files/setup.sh"
        destination = "/tmp/setup.sh"
    }

    # run provisioning script via secure shell 
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
  value = "${digitalocean_droplet.jenkinsci-server.ipv4_address}"
}