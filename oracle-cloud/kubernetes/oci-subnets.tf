resource "oci_core_subnet" "worker_nodes" {
  vcn_id = oci_core_vcn.main.id

  display_name   = "${oci_core_vcn.main.display_name}-worker-nodes-subnet"
  compartment_id = oci_core_vcn.main.compartment_id

  cidr_block = local.subnets.worker_nodes

  route_table_id = oci_core_route_table.natgw.id

  prohibit_public_ip_on_vnic = true

  security_list_ids = [oci_core_security_list.worker_nodes.id]
}

resource "oci_core_subnet" "api_endpoint" {
  vcn_id = oci_core_vcn.main.id

  display_name   = "${oci_core_vcn.main.display_name}-api-endpoint-subnet"
  compartment_id = oci_core_vcn.main.compartment_id

  cidr_block = local.subnets.api_endpoint

  route_table_id = oci_core_route_table.igw.id

  security_list_ids = [oci_core_security_list.api_endpoint.id]
}

resource "oci_core_subnet" "lbs" {
  vcn_id = oci_core_vcn.main.id

  display_name   = "${oci_core_vcn.main.display_name}-lbs-subnet"
  compartment_id = oci_core_vcn.main.compartment_id

  cidr_block = local.subnets.lbs

  route_table_id = oci_core_route_table.igw.id

  security_list_ids = [oci_core_security_list.lbs.id]
}

resource "oci_core_subnet" "pods" {
  vcn_id = oci_core_vcn.main.id

  display_name   = "${oci_core_vcn.main.display_name}-pods-subnet"
  compartment_id = oci_core_vcn.main.compartment_id

  cidr_block = local.subnets.pods

  route_table_id = oci_core_route_table.natgw.id

  prohibit_public_ip_on_vnic = true

  security_list_ids = [oci_core_security_list.pods.id]
}
