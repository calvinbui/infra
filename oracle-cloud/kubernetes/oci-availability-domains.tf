data "oci_identity_availability_domains" "worker_nodes" {
  compartment_id = oci_core_subnet.worker_nodes.compartment_id
}
