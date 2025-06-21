resource "cloudflare_dns_record" "dkim_fm1" {
  zone_id = cloudflare_zone.main.id
  type    = "CNAME"
  content = "fm1.${cloudflare_zone.main.name}.dkim.fmhosted.com"
  name    = "fm1._domainkey.${cloudflare_zone.main.name}"
  ttl     = 1
}

resource "cloudflare_dns_record" "dkim_fm2" {
  zone_id = cloudflare_zone.main.id
  type    = "CNAME"
  content = "fm2.${cloudflare_zone.main.name}.dkim.fmhosted.com"
  name    = "fm2._domainkey.${cloudflare_zone.main.name}"
  ttl     = 1
}

resource "cloudflare_dns_record" "dkim_fm3" {
  zone_id = cloudflare_zone.main.id
  type    = "CNAME"
  content = "fm3.${cloudflare_zone.main.name}.dkim.fmhosted.com"
  name    = "fm3._domainkey.${cloudflare_zone.main.name}"
  ttl     = 1
}

resource "cloudflare_dns_record" "dkim_fm4" {
  zone_id = cloudflare_zone.main.id
  type    = "CNAME"
  content = "mesmtp.${cloudflare_zone.main.name}.dkim.fmhosted.com"
  name    = "mesmtp._domainkey.${cloudflare_zone.main.name}"
  ttl     = 1
}
