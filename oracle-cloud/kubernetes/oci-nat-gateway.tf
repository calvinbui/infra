resource "oci_core_nat_gateway" "natgw" {
  vcn_id = oci_core_vcn.main.id

  display_name   = "${oci_core_vcn.main.display_name}-natgw"
  compartment_id = oci_core_vcn.main.compartment_id
}

resource "oci_core_route_table" "natgw" {
  vcn_id = oci_core_vcn.main.id

  display_name   = "${oci_core_nat_gateway.natgw.display_name}-route"
  compartment_id = oci_core_nat_gateway.natgw.compartment_id

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.natgw.id
  }

  route_rules {
    destination       = lookup(data.oci_core_services.all_oci_services.services[0], "cidr_block")
    destination_type  = "SERVICE_CIDR_BLOCK"
    network_entity_id = oci_core_service_gateway.sgw.id
  }
}
