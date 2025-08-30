terraform {
  cloud {
    organization = "homelab"

    workspaces {
      name = "oracle-cloud-kubernetes"
    }
  }
}
