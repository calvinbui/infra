variable "email_domains" {
  sensitive = false
}

locals {
  zones = [for domain in split(",", var.email_domains) : trimspace(domain)]
}
