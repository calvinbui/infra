resource "oci_containerengine_cluster" "main" {
  # 1. Create cluster
  name               = "${local.name}-cluster"
  compartment_id     = oci_core_vcn.main.compartment_id
  kubernetes_version = "v1.33.1"

  image_policy_config {
    is_policy_enabled = false
  }

  # 2. Network setup
  cluster_pod_network_options {
    cni_type = "OCI_VCN_IP_NATIVE"
  }

  vcn_id = oci_core_vcn.main.id

  endpoint_config {
    subnet_id            = oci_core_subnet.public.id
    is_public_ip_enabled = true
  }

  options {
    service_lb_subnet_ids = [oci_core_subnet.public.id]
  }

  # Other
  type = "BASIC_CLUSTER"
}
