# Configura terraform
terraform {
  backend "s3" {
    bucket  = "civica-terraform-backend"
    key     = "urbem-puebla/staging"
    profile = "terraform"
    region  = "us-east-1"
  }
}

# Variables
variable "project_name" {
  default = "urbem-puebla"
}

variable "jenkins_ssh_key_id" {
  default = 11986881
}

variable "digital_ocean_token" {}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = "${var.digital_ocean_token}"
}

# Create a web server
resource "digitalocean_droplet" "web" {
  image     = "ubuntu-14-04-x64"
  name      = "${var.project_name}"
  region    = "nyc3"
  size      = "2gb"
  ssh_keys  = ["${var.jenkins_ssh_key_id}"]
  user_data = "${data.template_file.setup_server.rendered}"
}

# Add a record alias to our staging domain
resource "digitalocean_record" "civicadesarrolla" {
  domain = "civicadesarrolla.me"
  type   = "A"
  name   = "${var.project_name}"
  value  = "${digitalocean_droplet.web.ipv4_address}"
}

# Data
data "template_file" "setup_server" {
  template = "${file("setup-server.sh")}"

  vars {
    project_name = "${var.project_name}"
  }
}

# Output
output "ip" {
  value = "${digitalocean_droplet.web.ipv4_address}"
}

output "url" {
  value = "${digitalocean_record.civicadesarrolla.fqdn}"
}
