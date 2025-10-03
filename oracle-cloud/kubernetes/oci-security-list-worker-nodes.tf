resource "oci_core_security_list" "worker_nodes" {
  vcn_id = oci_core_vcn.main.id

  display_name   = "${oci_core_vcn.main.display_name}-worker-nodes-sl"
  compartment_id = oci_core_vcn.main.compartment_id

  ingress_security_rules {
    description = "Allow Kubernetes API endpoint to communicate with worker nodes"
    source      = local.subnets.api_endpoint
    protocol    = local.protocol_numbers["TCP"]
    tcp_options {
      min = 10250
      max = 10250
    }
  }

  ingress_security_rules {
    description = "Allow pods to communicate with worker nodes"
    source      = local.subnets.pods
    protocol    = local.protocol_numbers["TCP"]
    tcp_options {
      min = 10250
      max = 10250
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
    description = "Allow inbound SSH traffic to managed nodes"
    source      = local.subnets.bastion
    protocol    = local.protocol_numbers["TCP"]
    tcp_options {
      min = 22
      max = 22
    }
  }

  ingress_security_rules {
    description = "Load balancer to worker nodes node TCP ports"
    source      = "0.0.0.0/0"
    protocol    = local.protocol_numbers["TCP"]
    tcp_options {
      min = 30000
      max = 32767
    }
  }

  ingress_security_rules {
    description = "Load balancer to worker nodes node UDP ports"
    source      = "0.0.0.0/0"
    protocol    = local.protocol_numbers["UDP"]
    udp_options {
      min = 30000
      max = 32767
    }
  }

  ingress_security_rules {
    description = "Allow load balancer to communicate with kube-proxy on worker nodes"
    source      = local.subnets.lbs
    protocol    = local.protocol_numbers["TCP"]
    tcp_options {
      min = 10256
      max = 10256
    }
  }

  egress_security_rules {
    description = "Allow worker nodes to access pods"
    destination = local.subnets.pods
    protocol    = "all"
  }

  egress_security_rules {
    description = "Path Discovery"
    destination = "0.0.0.0/0"
    protocol    = local.protocol_numbers["ICMP"]
    icmp_options {
      type = 3
      code = 4
    }
  }

  egress_security_rules {
    description      = "Allow worker nodes to communicate with OKE"
    destination_type = "SERVICE_CIDR_BLOCK"
    destination      = lookup(data.oci_core_services.all_oci_services.services[0], "cidr_block")
    protocol         = "all"
  }

  egress_security_rules {
    description = "Kubernetes worker to Kubernetes API endpoint communication"
    destination = local.subnets.api_endpoint
    protocol    = local.protocol_numbers["TCP"]
    tcp_options {
      min = 6443
      max = 6443
    }
  }

  egress_security_rules {
    description = "Kubernetes worker to Kubernetes API endpoint communication"
    destination = local.subnets.api_endpoint
    protocol    = local.protocol_numbers["TCP"]
    tcp_options {
      min = 12250
      max = 12250
    }
  }

  egress_security_rules {
    description = "Allow worker nodes to pull images from the Internet"
    destination = "0.0.0.0/0"
    protocol    = local.protocol_numbers["TCP"]
    tcp_options {
      min = 443
      max = 443
    }
  }
}

