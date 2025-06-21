resource "cloudflare_dns_record" "mx_10" {
  content  = "in1-smtp.messagingengine.com"
  zone_id  = cloudflare_zone.main.id
  type     = "MX"
  name     = cloudflare_zone.main.name
  priority = 10
  ttl      = 1
}

resource "cloudflare_dns_record" "mx_20" {
  content  = "in2-smtp.messagingengine.com"
  zone_id  = cloudflare_zone.main.id
  type     = "MX"
  name     = cloudflare_zone.main.name
  priority = 20
  ttl      = 1
}
