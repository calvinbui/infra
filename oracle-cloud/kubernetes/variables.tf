locals {
  name = "k8s"

  nodepool_size = 2

  subnets = {
    vcn = "10.127.80.0/21"

    bastion      = "10.127.80.0/24"
    api_endpoint = "10.127.81.0/24"
    lbs          = "10.127.82.0/24"
    worker_nodes = "10.127.83.0/24"
    pods         = "10.127.84.0/22"
  }
}
