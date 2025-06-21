resource "cloudflare_dns_record" "srv_autodiscover" {
  zone_id  = cloudflare_zone.main.id
  type     = "SRV"
  name     = "_autodiscover._tcp.${cloudflare_zone.main.name}"
  priority = 0
  ttl      = 1
  data = {
    port     = 443
    priority = 0
    target   = "autodiscover.fastmail.com"
    weight   = 1
  }
}

resource "cloudflare_dns_record" "srv_imaps" {
  zone_id  = cloudflare_zone.main.id
  type     = "SRV"
  name     = "_imaps._tcp.${cloudflare_zone.main.name}"
  priority = 0
  ttl      = 1
  data = {
    port     = 993
    priority = 0
    target   = "imap.fastmail.com"
    weight   = 1
  }
}

resource "cloudflare_dns_record" "srv_imap" {
  zone_id  = cloudflare_zone.main.id
  type     = "SRV"
  name     = "_imap._tcp.${cloudflare_zone.main.name}"
  priority = 0
  ttl      = 1
  data = {
    port     = 0
    priority = 0
    target   = "."
    weight   = 0
  }
}

resource "cloudflare_dns_record" "srv_jmap" {
  zone_id  = cloudflare_zone.main.id
  type     = "SRV"
  name     = "_jmap._tcp.${cloudflare_zone.main.name}"
  priority = 0
  ttl      = 1
  data = {
    port     = 443
    priority = 0
    target   = "api.fastmail.com"
    weight   = 1
  }
}

resource "cloudflare_dns_record" "srv_pop3s" {
  zone_id  = cloudflare_zone.main.id
  type     = "SRV"
  name     = "_pop3s._tcp.${cloudflare_zone.main.name}"
  priority = 10
  ttl      = 1
  data = {
    port     = 995
    priority = 10
    target   = "pop.fastmail.com"
    weight   = 1
  }
}

resource "cloudflare_dns_record" "srv_pop3" {
  zone_id  = cloudflare_zone.main.id
  type     = "SRV"
  name     = "_pop3._tcp.${cloudflare_zone.main.name}"
  priority = 0
  ttl      = 1
  data = {
    port     = 0
    priority = 0
    target   = "."
    weight   = 0
  }
}

resource "cloudflare_dns_record" "srv_submissions" {
  zone_id  = cloudflare_zone.main.id
  type     = "SRV"
  name     = "_submissions._tcp.${cloudflare_zone.main.name}"
  priority = 0
  ttl      = 1
  data = {
    port     = 465
    priority = 0
    target   = "smtp.fastmail.com"
    weight   = 1
  }
}

resource "cloudflare_dns_record" "srv_submission" {
  zone_id  = cloudflare_zone.main.id
  type     = "SRV"
  name     = "_submission._tcp.${cloudflare_zone.main.name}"
  priority = 0
  ttl      = 1
  data = {
    port     = 0
    priority = 0
    target   = "."
    weight   = 0
  }
}
