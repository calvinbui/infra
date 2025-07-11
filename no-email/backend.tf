terraform {
  cloud {
    organization = "homelab"

    workspaces {
      name = "no-email"
    }
  }
}
