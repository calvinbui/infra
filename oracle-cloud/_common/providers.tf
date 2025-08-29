terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "7.15.0"
    }
  }
}

variable "tenancy_ocid" {
  sensitive = false
}

variable "oci_private_key" {
  sensitive = true
}

provider "oci" {
  tenancy_ocid = var.tenancy_ocid
  private_key  = var.oci_private_key
}
