resource "oci_core_internet_gateway" "igw" {
  vcn_id = oci_core_vcn.main.id

  display_name   = "${oci_core_vcn.main.display_name}-igw"
  compartment_id = oci_core_vcn.main.compartment_id
}

resource "oci_core_route_table" "igw" {
  vcn_id = oci_core_vcn.main.id

  display_name   = "${oci_core_internet_gateway.igw.display_name}-igw-route"
  compartment_id = oci_core_internet_gateway.igw.compartment_id

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.igw.id
  }
}
