resource "oci_bastion_bastion" "main" {
  compartment_id = oci_core_vcn.main.compartment_id

  bastion_type = "STANDARD"

  name                         = "${local.name}-bastion"
  target_subnet_id             = oci_core_subnet.bastion.id
  client_cidr_block_allow_list = ["0.0.0.0/0"]
}
