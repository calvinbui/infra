resource "oci_core_vcn" "main" {
  display_name   = "${local.name}-vcn"
  compartment_id = var.tenancy_ocid

  cidr_blocks = [local.subnets.vcn]
  dns_label   = "${local.name}vcn"
}
