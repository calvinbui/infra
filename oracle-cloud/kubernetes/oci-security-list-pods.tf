resource "oci_core_security_list" "pods" {
  vcn_id = oci_core_vcn.main.id

  display_name   = "${oci_core_vcn.main.display_name}-pods-sl"
  compartment_id = oci_core_vcn.main.compartment_id

  ingress_security_rules {
    description = "Allow worker nodes to access pods"
    source      = local.subnets.worker_nodes
    protocol    = "all"
  }

  ingress_security_rules {
    description = "Allow Kubernetes API endpoint to communicate with pods"
    source      = local.subnets.api_endpoint
    protocol    = "all"
  }

  ingress_security_rules {
    description = "Allow pods to communicate with other pods"
    source      = local.subnets.pods
    protocol    = "all"
  }

  egress_security_rules {
    description = "Allow pods to communicate with other pods"
    destination = local.subnets.pods
    protocol    = "all"
  }

  egress_security_rules {
    description = "Allow pods to get worker node metrics"
    destination = local.subnets.worker_nodes
    protocol    = local.protocol_numbers["TCP"]
    tcp_options {
      min = 10250
      max = 10250
    }
  }

  egress_security_rules {
    description      = "Path Discovery"
    destination_type = "SERVICE_CIDR_BLOCK"
    destination      = lookup(data.oci_core_services.all_oci_services.services[0], "cidr_block")
    protocol         = local.protocol_numbers["ICMP"]
    icmp_options {
      type = 3
      code = 4
    }
  }

  egress_security_rules {
    description      = "Allow pods to communicate with OCI services"
    destination_type = "SERVICE_CIDR_BLOCK"
    destination      = lookup(data.oci_core_services.all_oci_services.services[0], "cidr_block")
    protocol         = local.protocol_numbers["TCP"]
    tcp_options {
      min = 1
      max = 65535
    }
  }

  egress_security_rules {
    description = "Allow pods to communicate with internet"
    destination = "0.0.0.0/0"
    protocol    = local.protocol_numbers["TCP"]
    tcp_options {
      min = 80
      max = 80
    }
  }

  egress_security_rules {
    description = "Allow pods to communicate with internet"
    destination = "0.0.0.0/0"
    protocol    = local.protocol_numbers["TCP"]
    tcp_options {
      min = 53
      max = 53
    }
  }

  egress_security_rules {
    description = "Allow pods to communicate with internet"
    destination = "0.0.0.0/0"
    protocol    = local.protocol_numbers["TCP"]
    tcp_options {
      min = 443
      max = 443
    }
  }

  egress_security_rules {
    description = "Pod to Kubernetes API endpoint communication"
    destination = local.subnets.api_endpoint
    protocol    = local.protocol_numbers["TCP"]
    tcp_options {
      min = 6443
      max = 6443
    }
  }

  egress_security_rules {
    description = "Pod to Kubernetes API endpoint communication"
    destination = local.subnets.api_endpoint
    protocol    = local.protocol_numbers["TCP"]
    tcp_options {
      min = 12250
      max = 12250
    }
  }
}
