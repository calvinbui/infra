resource "cloudflare_zone" "main" {
  account = {
    id = "b4e8d4a2b400038b0c45bee1eb5c6219"
  }

  name = var.email_domain
  type = "full"
}
