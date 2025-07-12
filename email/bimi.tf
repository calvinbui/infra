resource "cloudflare_r2_bucket" "bimi" {
  account_id    = var.account_id
  name          = "${replace(cloudflare_zone.main.name, ".", "-")}-bimi"
  jurisdiction  = "default"
  location      = "OC"
  storage_class = "Standard"
}

resource "cloudflare_r2_custom_domain" "bimi" {
  account_id  = var.account_id
  bucket_name = cloudflare_r2_bucket.bimi.name
  domain      = "bimi.${cloudflare_zone.main.name}"
  enabled     = true
  zone_id     = cloudflare_zone.main.id
  min_tls     = "1.2"
}


variable "r2_access_key_id" {
  type = string
}

variable "r2_secret_access_key" {
  type      = string
  sensitive = true
}

provider "aws" {
  region            = "us-east-1"
  s3_use_path_style = true

  access_key = var.r2_access_key_id
  secret_key = var.r2_secret_access_key

  skip_credentials_validation = true
  skip_region_validation      = true
  skip_requesting_account_id  = true

  endpoints {
    s3 = "https://${var.account_id}.r2.cloudflarestorage.com"
  }
}

resource "aws_s3_object" "bimi" {
  bucket       = cloudflare_r2_bucket.bimi.name
  key          = "bimi.svg"
  source       = "bimi.svg"
  content_type = "image/svg+xml"
  etag         = filemd5("bimi.svg")

  lifecycle {
    ignore_changes = [content_encoding]
  }
}

resource "cloudflare_dns_record" "bimi" {
  zone_id = cloudflare_zone.main.id
  type    = "TXT"
  content = "\"v=BIMI1; l=https://${cloudflare_r2_custom_domain.bimi.domain}/bimi.svg;\""
  name    = "default._bimi.${cloudflare_zone.main.name}"
  ttl     = 1
}
