resource "cloudflare_dns_record" "spf_policy" {
  zone_id = cloudflare_zone.main.id
  type    = "TXT"
  content = "\"v=spf1 include:spf.messagingengine.com -all\""
  name    = cloudflare_zone.main.name
  ttl     = 1
}
