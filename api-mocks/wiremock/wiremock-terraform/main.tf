#
# main Terraform file
# describes provisioning steps for setup
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
    
    provisioner "file" {
        source      = "files/mocks"
        destination = "/tmp/mocks"
    }
    provisioner "file" {
        source      = "files/setup_mocks.py"
        destination = "/tmp/setup_mocks.py"
    }

    # run all necessary commands via secure shell 
    provisioner "remote-exec" {
        inline = [
            # add required file permissions
            "chmod 755 /tmp/setup.sh",
            "chmod 755 /tmp/setup_mocks.py",
            # run the VM setup script
            "/tmp/setup.sh",
            "echo sleep 10s to allow WireMock container boot up; sleep 10",
            # run mock mappings provisioning
            "cd /tmp && python setup_mocks.py"
        ]
    }
}

# print out ip address of created Jenkins server VM
output "service-ip" {
  value = "your new instance is running with IP address: ${digitalocean_droplet.popularowl-server.ipv4_address}"
}