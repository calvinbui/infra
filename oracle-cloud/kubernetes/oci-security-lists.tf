########################
# Private
########################

resource "oci_core_security_list" "private" {
  vcn_id = oci_core_vcn.main.id

  display_name   = "${oci_core_vcn.main.display_name}-private-sl"
  compartment_id = oci_core_vcn.main.compartment_id

  ingress_security_rules {
    source      = oci_core_vcn.main.cidr_blocks[0]
    protocol    = "all"
    description = "VCN"
  }

  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
    description = "Anywhere"
  }
}

########################
# Public
########################

resource "oci_core_security_list" "public" {
  vcn_id = oci_core_vcn.main.id

  display_name   = "${oci_core_vcn.main.display_name}-public-sl"
  compartment_id = oci_core_vcn.main.compartment_id

  ingress_security_rules {
    source      = oci_core_vcn.main.cidr_blocks[0]
    protocol    = "all"
    description = "VCN"
  }

  ingress_security_rules {
    source   = "0.0.0.0/0"
    protocol = "6" # TCP
    tcp_options {
      min = 6443
      max = 6443
    }
    description = "Internet access to K8S API"
  }

  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
    description = "Anywhere"
  }
}

########################
# Load Balancer
########################

resource "oci_core_security_list" "lb" {
  vcn_id = oci_core_vcn.main.id

  display_name   = "${oci_core_vcn.main.display_name}-lb-sl"
  compartment_id = oci_core_vcn.main.compartment_id

  ingress_security_rules {
    source   = "0.0.0.0/0"
    protocol = "6" # TCP
    tcp_options {
      min = 30000
      max = 32767
    }
  }
}
