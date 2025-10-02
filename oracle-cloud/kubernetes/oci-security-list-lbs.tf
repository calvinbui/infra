resource "oci_core_security_list" "lbs" {
  vcn_id = oci_core_vcn.main.id

  display_name   = "${oci_core_vcn.main.display_name}-lbs-sl"
  compartment_id = oci_core_vcn.main.compartment_id

  ingress_security_rules {
    description = "Load balancer HTTPS"
    source      = "0.0.0.0/0"
    protocol    = local.protocol_numbers["TCP"]
    tcp_options {
      max = 443
      min = 443
    }
  }

  ingress_security_rules {
    description = "Load balancer HTTP3"
    source      = "0.0.0.0/0"
    protocol    = local.protocol_numbers["UDP"]
    udp_options {
      max = 8443
      min = 8443
    }
  }

  ingress_security_rules {
    description = "Load balancer HTTP"
    source      = "0.0.0.0/0"
    protocol    = local.protocol_numbers["TCP"]
    tcp_options {
      max = 80
      min = 80
    }
  }

  egress_security_rules {
    description = "Load balancer to worker nodes node ports"
    destination = local.subnets.worker_nodes
    protocol    = local.protocol_numbers["TCP"]
    tcp_options {
      min = 30000
      max = 32767
    }
  }

  egress_security_rules {
    description = "Load balancer to worker nodes node ports"
    destination = local.subnets.worker_nodes
    protocol    = local.protocol_numbers["UDP"]
    udp_options {
      min = 30000
      max = 32767
    }
  }

  egress_security_rules {
    description = "Allow load balancer to communicate with kube-proxy on worker nodes"
    destination = local.subnets.worker_nodes
    protocol    = local.protocol_numbers["TCP"]
    tcp_options {
      min = 10256
      max = 10256
    }
  }
}

