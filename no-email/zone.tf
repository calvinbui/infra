data "cloudflare_zones" "main" {
  for_each = toset(local.zones)

  name = each.value
}
