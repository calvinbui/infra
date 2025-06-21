terraform {
  cloud {
    organization = "homelab"

    workspaces {
      name = "email"
    }
  }
}
