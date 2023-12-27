locals {
  deploy_date = replace(timestamp(), ":", "-")
}

resource "hcloud_firewall" "mc_node-firewall" {
  name = "mc-node"
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

resource "hcloud_ssh_key" "mc_node-ssh_key" {
  name = "mc-node"
  public_key = file("./mc.key.pub")
}

resource "hcloud_primary_ip" "mc_node-ip4" {
  name = "mc-node"
  datacenter = var.mc_node-datacenter
  type = "ipv4"
  assignee_type = "server"
  auto_delete = false
}

resource "desec_rrset" "mc_node-record" {
  domain = var.ds_domain
  subname = "mc"
  type = "A"
  records = [ hcloud_primary_ip.mc_node-ip4.ip_address ]
  ttl = 3600
}

resource "hcloud_server" "mc_node" {
  name = "${format("%s-%s", "mc-node", local.deploy_date)}"
  image = "debian-11"
  server_type = var.mc_node-server_type
  datacenter = var.mc_node-datacenter
  ssh_keys = [ "mc-node" ]
  firewall_ids = [ hcloud_firewall.mc_node-firewall.id ]
  public_net {
    ipv6_enabled = false
    ipv4 = hcloud_primary_ip.mc_node-ip4.id
  }
  user_data = file("./cloud-init.yml")
}
