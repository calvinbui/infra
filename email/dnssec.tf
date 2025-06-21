resource "cloudflare_zone_dnssec" "main" {
  zone_id = cloudflare_zone.main.id
  status  = "active"

  # lifecycle {
  #   ignore_changes = [status]
  # }
}
