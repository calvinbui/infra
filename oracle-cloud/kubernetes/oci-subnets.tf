########################
# Private
########################

resource "oci_core_subnet" "private" {
  vcn_id = oci_core_vcn.main.id

  display_name   = "${oci_core_vcn.main.display_name}-private-subnet"
  compartment_id = oci_core_vcn.main.compartment_id

  cidr_block = cidrsubnets(oci_core_vcn.main.cidr_blocks[0], 1, 1)[0]

  route_table_id = oci_core_route_table.natgw.id

  prohibit_public_ip_on_vnic = true

  security_list_ids = [
    oci_core_security_list.private.id,
    oci_core_security_list.lb.id,
  ]
}

########################
# Public
########################

resource "oci_core_subnet" "public" {
  vcn_id = oci_core_vcn.main.id

  display_name   = "${oci_core_vcn.main.display_name}-public-subnet"
  compartment_id = oci_core_vcn.main.compartment_id

  cidr_block = cidrsubnets(oci_core_vcn.main.cidr_blocks[0], 1, 1)[1]

  route_table_id = oci_core_route_table.igw.id

  security_list_ids = [oci_core_security_list.public.id]
}
