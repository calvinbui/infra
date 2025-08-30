resource "oci_core_vcn" "main" {
  display_name   = "${local.name}-vcn"
  compartment_id = var.tenancy_ocid

  cidr_blocks = ["10.127.8.0/24"]
  dns_label   = "${local.name}vcn"
}
