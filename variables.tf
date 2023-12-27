variable "hc_token" {
  description = "Hetzner Cloud project API token"
  type = string
  sensitive = true
}

variable "ds_token" {
  description = "Desec account API token"
  type = string
  sensitive = true
}

variable "ds_domain" {
  description = "Desec domain to use"
  type = string
  default = "ldryt.dev"
}

variable "mc_node-server_type" {
  description = "Hetzner Cloud server type"
  type = string
  default = "ccx23"
}

variable "mc_node-datacenter" {
  description = "Hetzner Cloud datacenter"
  type = string
  default = "nbg1-dc3"
}
