# Cloudflare adds CAA records automatically when it generates certificates
# https://developers.cloudflare.com/ssl/edge-certificates/caa-records/#caa-records-added-by-cloudflare
resource "cloudflare_dns_record" "caa" {
  zone_id = cloudflare_zone.main.id
  type    = "CAA"
  name    = cloudflare_zone.main.name
  data = {
    flags = 0
    tag   = "issue"
    value = ";"
  }
  ttl = 1
}
