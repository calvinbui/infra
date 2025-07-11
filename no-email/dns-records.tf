resource "cloudflare_dns_record" "spf" {
  for_each = data.cloudflare_zones.main

  zone_id = each.value.result[0].id
  type    = "TXT"
  content = "\"v=spf1 -all\""
  name    = each.value.result[0].name
  ttl     = 1
}

resource "cloudflare_dns_record" "dkim" {
  for_each = data.cloudflare_zones.main

  zone_id = each.value.result[0].id
  type    = "TXT"
  content = "\"v=DKIM1; p=\""
  name    = "*._domainkey.${each.value.result[0].name}"
  ttl     = 1
}

resource "cloudflare_dns_record" "dmarc" {
  for_each = data.cloudflare_zones.main

  zone_id = each.value.result[0].id
  type    = "TXT"
  content = "\"v=DMARC1;p=reject;sp=reject;adkim=s;aspf=s\""
  name    = "_dmarc.${each.value.result[0].name}"
  ttl     = 1
}
