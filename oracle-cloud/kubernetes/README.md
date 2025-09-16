# Oracle Cloud Kubernetes Always Free Tier

Deploys an always free tier OKE cluster with worker nodes

## Free Resources

- Basic Oracle Kubernetes Engine cluster
- VM.Standard.A1.Flex compute instances (4 CPUs, 24GB RAM, 200GB storage), split across 2 nodes
- Virtual Cloud Network (VCN) with all gateways, route tables, subnets and security lists

## Availability Domains

Most regions only [have 1 availability domain](https://docs.oracle.com/en-us/iaas/Content/General/Concepts/regions.htm), but with multiple fault domains.

Fault domains are physical hardware within an availability domain. Nodes should be distributed across both availability domains and fault domains if possible. Persistent volumes can move across fault domains, but not availability domains.

## Credits

- https://github.com/nce/oci-free-cloud-k8s
- https://github.com/oracle-terraform-modules/terraform-oci-oke
- https://github.com/oracle-terraform-modules/terraform-oci-vcn
