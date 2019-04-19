#
# main Terraform file to describe automation
#

# choose Digital Ocean provider
provider "digitalocean" {
  token = "${var.token}"
}

# create VM instance on Digital Ocean
resource "digitalocean_droplet" "jenkinsci-server" {
    image = "${var.droplet_image}"
    name = "jenkinsci-server"
    region = "${var.region}"
    size = "${var.jenkins_droplet_size}"
    ssh_keys = [
        "${var.ssh_fingerprint}"
    ]

    connection {
        user = "root"
        type = "ssh"
        private_key = "${file(var.pvt_sshkey)}"
        timeout = "2m"
    }

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

    provisioner "remote-exec" {
        inline = [

            # steps to setup docker ce
            "apt update",
            "apt -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common",
            "curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -",
            "add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable\" ",
            "apt update",
            "apt-cache policy docker-ce",
            "apt -y install docker-ce",

            # build jenkins image with default admin user
            "cd /tmp && docker build -t popularowl/jenkins .",

            # run newly built jenkins container on port 8080
            "docker run -d --name jenkins-server -p 8080:8080 popularowl/jenkins",

            # install remaining dependencies
            "apt -y install nginx",
            "apt -y install ufw",
            
            # setup debian firewall
            "ufw status verbose",
            "ufw default deny incoming",
            "ufw default allow outgoing",
            "ufw allow ssh",
            "ufw allow 22",
            "ufw allow 80",
            "yes | ufw enable",
            
            # update nginx configuration
            "rm -f /etc/nginx/sites-enabled/default",
            "cp -f /tmp/jenkins-proxy /etc/nginx/sites-enabled",
            "service nginx restart"        
        ]
    }
}

# print out ip address of created Jenkins server VM
output "service-ip" {
  value = "${digitalocean_droplet.jenkinsci-server.ipv4_address}"
}