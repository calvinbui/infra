locals {
  name = "k8s"

  subnets = {
    vcn = "10.127.80.0/21"

    api_endpoint = "10.127.80.0/24"
    lbs          = "10.127.81.0/24"
    worker_nodes = "10.127.82.0/23"
    pods         = "10.127.84.0/22"
  }
}
