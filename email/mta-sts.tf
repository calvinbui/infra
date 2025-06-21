resource "cloudflare_workers_script" "mta_sts" {
  account_id  = cloudflare_zone.main.account.id
  script_name = "mta-sts-${replace(cloudflare_zone.main.name, ".", "-")}"
  content     = file("${path.module}/worker.js")
}

resource "cloudflare_workers_custom_domain" "mta_sts" {
  account_id  = cloudflare_workers_script.mta_sts.account_id
  environment = "production"
  hostname    = "mta-sts.${cloudflare_zone.main.name}"
  service     = cloudflare_workers_script.mta_sts.script_name
  zone_id     = cloudflare_zone.main.id
}

resource "cloudflare_dns_record" "mta_sts" {
  zone_id = cloudflare_zone.main.id
  type    = "TXT"
  content = "\"v=STSv1; id=${md5(file("${path.module}/worker.js"))}\""
  name    = "_mta-sts.${cloudflare_zone.main.name}"
  ttl     = 1
}

resource "cloudflare_dns_record" "tls_rpt" {
  zone_id = cloudflare_zone.main.id
  type    = "TXT"
  content = "\"v=TLSRPTv1; rua=mailto:fea0c8ce@in.mailhardener.com\""
  name    = "_smtp._tls.${cloudflare_zone.main.name}"
  ttl     = 1
}

resource "cloudflare_api_shield_operation" "mta_sts" {
  zone_id  = cloudflare_zone.main.id
  endpoint = "/.well-known/mta-sts.txt"
  host     = cloudflare_workers_custom_domain.mta_sts.hostname
  method   = "GET"
}
