resource "oci_core_security_list" "bastion" {
  vcn_id = oci_core_vcn.main.id

  display_name   = "${oci_core_vcn.main.display_name}-bastion-sl"
  compartment_id = oci_core_vcn.main.compartment_id

  egress_security_rules {
    description = "Allow bastion to access the Kubernetes API endpoint"
    destination = local.subnets.api_endpoint
    protocol    = local.protocol_numbers["TCP"]
    tcp_options {
      min = 6443
      max = 6443
    }
  }

  egress_security_rules {
    description = "Allow SSH traffic to worker nodes"
    destination = local.subnets.worker_nodes
    protocol    = local.protocol_numbers["TCP"]
    tcp_options {
      min = 22
      max = 22
    }
  }
}

