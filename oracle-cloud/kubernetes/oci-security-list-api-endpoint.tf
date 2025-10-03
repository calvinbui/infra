resource "oci_core_security_list" "api_endpoint" {
  vcn_id = oci_core_vcn.main.id

  display_name   = "${oci_core_vcn.main.display_name}-api-endpoint-sl"
  compartment_id = oci_core_vcn.main.compartment_id

  ingress_security_rules {
    description = "Kubernetes worker to Kubernetes API endpoint communication"
    source      = local.subnets.worker_nodes
    protocol    = local.protocol_numbers["TCP"]
    tcp_options {
      min = 6443
      max = 6443
    }
  }

  ingress_security_rules {
    description = "Kubernetes worker to Kubernetes API endpoint communication"
    source      = local.subnets.worker_nodes
    protocol    = local.protocol_numbers["TCP"]
    tcp_options {
      min = 12250
      max = 12250
    }
  }

  ingress_security_rules {
    description = "Path Discovery"
    source      = "0.0.0.0/0"
    protocol    = local.protocol_numbers["ICMP"]
    icmp_options {
      type = 3
      code = 4
    }
  }

  ingress_security_rules {
    description = "Pod to Kubernetes API endpoint communication"
    source      = local.subnets.pods
    protocol    = local.protocol_numbers["TCP"]
    tcp_options {
      min = 6443
      max = 6443
    }
  }

  ingress_security_rules {
    description = "Pod to Kubernetes API endpoint communication"
    source      = local.subnets.pods
    protocol    = local.protocol_numbers["TCP"]
    tcp_options {
      min = 12250
      max = 12250
    }
  }

  ingress_security_rules {
    description = "Bastion access to Kubernetes API endpoint"
    source      = local.subnets.bastion
    protocol    = local.protocol_numbers["TCP"]
    tcp_options {
      min = 6443
      max = 6443
    }
  }

  ingress_security_rules {
    description = "External access to Kubernetes API endpoint"
    source      = "0.0.0.0/0"
    protocol    = local.protocol_numbers["TCP"]
    tcp_options {
      min = 6443
      max = 6443
    }
  }

  egress_security_rules {
    description      = "Allow Kubernetes API endpoint to communicate with OKE"
    destination_type = "SERVICE_CIDR_BLOCK"
    destination      = lookup(data.oci_core_services.all_oci_services.services[0], "cidr_block")
    protocol         = local.protocol_numbers["TCP"]
    tcp_options {
      min = 1
      max = 65535
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
    description = "Allow Kubernetes API endpoint to communicate with worker nodes"
    destination = local.subnets.worker_nodes
    protocol    = local.protocol_numbers["TCP"]
    tcp_options {
      min = 10250
      max = 10250
    }
  }

  egress_security_rules {
    description = "Path Discovery"
    destination = local.subnets.worker_nodes
    protocol    = local.protocol_numbers["ICMP"]
    icmp_options {
      type = 3
      code = 4
    }
  }

  egress_security_rules {
    description = "Allow Kubernetes API endpoint to communicate with pods"
    destination = local.subnets.pods
    protocol    = "all"
  }
}

