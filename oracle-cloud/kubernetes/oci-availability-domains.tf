data "oci_identity_availability_domains" "private_subnet" {
  compartment_id = oci_core_subnet.private.compartment_id
}
