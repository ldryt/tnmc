variable "hc_token" {
  description = "Hetzner Cloud project API token"
  type = string
  sensitive = true
}

variable "gd_token" {
  description = "Gandi API token"
  type = string
  sensitive = true
}

variable "gd_domain" {
  description = "Gandi domain to use"
  type = string
}

variable "mcn_type" {
  description = "Hetzner Cloud server type"
  type = string
}

variable "mcn_datacenter" {
  description = "Hetzner Cloud datacenter name"
  type = string
}
