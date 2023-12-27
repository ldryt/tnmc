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
}

variable "mcn_type" {
  description = "Hetzner Cloud server type"
  type = string
}

variable "mcn_datacenter" {
  description = "Hetzner Cloud datacenter name"
  type = string
}
