resource "cloudflare_zone" "main" {
  account = {
    id = var.account_id
  }

  name = var.email_domain
  type = "full"
}
