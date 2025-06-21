resource "cloudflare_zone_setting" "ssl" {
  zone_id    = cloudflare_zone.main.id
  setting_id = "ssl"
  value      = "strict"
}

resource "cloudflare_zone_setting" "min_tls_version" {
  zone_id    = cloudflare_zone.main.id
  setting_id = "min_tls_version"
  value      = "1.2"
}

resource "cloudflare_zone_setting" "opportunistic_encryption" {
  zone_id    = cloudflare_zone.main.id
  setting_id = "opportunistic_encryption"
  value      = "off"
}

resource "cloudflare_zone_setting" "automatic_https_rewrites" {
  zone_id    = cloudflare_zone.main.id
  setting_id = "automatic_https_rewrites"
  value      = "off"
}
