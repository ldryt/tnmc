terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
      version = "~>1.44.1"
    }
    desec = {
      source = "valodim/desec"
      version = "~>0.3.0"
    }
  }
}

provider "hcloud" {
  token = var.hc_token
}

provider "desec" {
  api_token = var.ds_token
}
