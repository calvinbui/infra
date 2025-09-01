resource "oci_containerengine_node_pool" "main" {
  cluster_id = oci_containerengine_cluster.main.id

  name               = "${local.name}-pool"
  compartment_id     = oci_containerengine_cluster.main.compartment_id
  kubernetes_version = oci_containerengine_cluster.main.kubernetes_version

  node_config_details {
    size = 2

    dynamic "placement_configs" {
      for_each = data.oci_identity_availability_domains.private_subnet.availability_domains
      content {
        availability_domain = placement_configs.value.name
        subnet_id           = oci_core_subnet.private.id
      }
    }

    node_pool_pod_network_option_details {
      cni_type          = oci_containerengine_cluster.main.cluster_pod_network_options[0].cni_type
      pod_subnet_ids    = [oci_core_subnet.private.id]
      max_pods_per_node = 31
    }

    is_pv_encryption_in_transit_enabled = true
  }

  node_shape = "VM.Standard.A1.Flex"

  node_shape_config {
    ocpus         = 2
    memory_in_gbs = 12
  }

  node_source_details {
    source_type = "IMAGE"
    image_id = try(([for s in data.oci_containerengine_node_pool_option.node_pool_options.sources : s.image_id if
      strcontains(s.source_name, "aarch64") &&
      strcontains(s.source_name, "Oracle-Linux") &&
      !strcontains(s.source_name, "GPU") &&
      strcontains(s.source_name, "OKE-${trimprefix(oci_containerengine_cluster.main.kubernetes_version, "v")}")
    ])[0], null)
  }
}

data "oci_containerengine_node_pool_option" "node_pool_options" {
  node_pool_option_id = "all"
  compartment_id      = oci_containerengine_cluster.main.compartment_id
}
