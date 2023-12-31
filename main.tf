locals {
  deploy_date = replace(timestamp(), ":", "-")
}

resource "hcloud_firewall" "mcn_firewall" {
  name = "mcn"
  rule {
    direction = "in"
    protocol = "icmp"
    source_ips = [ "0.0.0.0/0" ]
  }
  rule {
    direction = "in"
    protocol = "tcp"
    port = "22"
    source_ips = [ "0.0.0.0/0" ]
  }
  rule {
    direction = "in"
    protocol = "tcp"
    port = "25565"
    source_ips = [ "0.0.0.0/0" ]
  }
}

resource "hcloud_ssh_key" "mcn_ssh_key" {
  name = "mcn"
  public_key = file("./mc.key.pub")
}

resource "hcloud_primary_ip" "mcn_ip4" {
  name = "mcn"
  datacenter = var.mcn_datacenter
  type = "ipv4"
  assignee_type = "server"
  auto_delete = false
}

resource "hcloud_server" "mcn" {
  name = "${format("%s-%s", "mcn", local.deploy_date)}"
  image = "debian-11"
  server_type = var.mcn_type
  datacenter = var.mcn_datacenter
  ssh_keys = [ "mcn" ]
  firewall_ids = [ hcloud_firewall.mcn_firewall.id ]
  public_net {
    ipv6_enabled = false
    ipv4 = hcloud_primary_ip.mcn_ip4.id
  }
  user_data = file("./cloud-init.yml")
}

data "gandi_domain" "mcn_domain" {
  name = var.gd_domain
}

resource "gandi_livedns_record" "mc_a_record" {
  zone = data.gandi_domain.mcn_domain.id
  name = "mc"
  type = "A"
  ttl = 300
  values = [ hcloud_primary_ip.mcn_ip4.ip_address ]
}
