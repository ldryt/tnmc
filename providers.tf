terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
      version = "~>1.44.1"
    }
    gandi = {
      source = "go-gandi/gandi"
      version = "~>2.2.4"
    }
  }
}

provider "hcloud" {
  token = var.hc_token
}

provider "gandi" {
  key = var.gd_token
}
