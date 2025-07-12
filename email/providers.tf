terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.5.0"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "6.2.0"
    }
  }
}

provider "cloudflare" {}
