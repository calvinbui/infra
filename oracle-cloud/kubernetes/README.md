# Oracle Cloud Kubernetes Always Free Tier

Deploys an always free tier OKE cluster with worker nodes

## Free Resources

- Basic Oracle Kubernetes Engine cluster
- VM.Standard.A1.Flex compute instances (4 CPUs, 24GB RAM, 200GB storage), split across 2 nodes
- Virtual Cloud Network (VCN) with all gateways, route tables, subnets and security lists

## Availability Domains

Most regions only [have 1 availability domain](https://docs.oracle.com/en-us/iaas/Content/General/Concepts/regions.htm), but with multiple fault domains.

Fault domains are physical hardware within an availability domain. Nodes should be distributed across both availability domains and fault domains if possible. Persistent volumes can move across fault domains, but not availability domains.

## Networking

Follows best practices from https://docs.oracle.com/en-us/iaas/Content/ContEng/Concepts/contengnetworkconfigexample.htm#example-oci-cni-publick8sapi_privateworkers_publiclb

## Updating

Read OKE changes first: https://docs.oracle.com/en-us/iaas/Content/ContEng/Concepts/contengaboutk8sversions.htm#supportedk8sversions

1. Update and apply `kubernetes_version` for `oci_containerengine_cluster.main`.
1. Cordon and drain one node. Do not delete it.
1. Log into the web console and delete the node from the node pool.
1. Wait for OKE to bring up a new node.
1. Wait for longhorn to sync its volumes.
1. Cycle the second node following the previous steps.

## Credits

- https://github.com/nce/oci-free-cloud-k8s
- https://github.com/oracle-terraform-modules/terraform-oci-oke
- https://github.com/oracle-terraform-modules/terraform-oci-vcn
