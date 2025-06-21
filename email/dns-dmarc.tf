resource "cloudflare_dns_record" "dmarc_policy" {
  zone_id = cloudflare_zone.main.id
  type    = "TXT"
  content = "\"v=DMARC1; p=reject; pct=100; rua=mailto:3c46bb06c2e6499da3e477169b4ebe90@dmarc-reports.cloudflare.net,mailto:re+lp6pphn6iuy@dmarc.postmarkapp.com,mailto:fea0c8ce@in.mailhardener.com; sp=reject; aspf=s; adkim=s; ruf=mailto:fea0c8ce@in.mailhardener.com;\""
  name    = "_dmarc.${cloudflare_zone.main.name}"
  ttl     = 1
}

resource "cloudflare_dns_record" "dkim_adsp_policy" {
  zone_id = cloudflare_zone.main.id
  type    = "TXT"
  content = "\"dkim=all\""
  name    = "_adsp._domainkey.${cloudflare_zone.main.name}"
  ttl     = 1
}
