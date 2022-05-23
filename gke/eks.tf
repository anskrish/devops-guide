module "eks_cluster-stage" {
  source = "./module/."
  location = "us-west3-b"
  node_count = 2
  tags = ["krishna", "devops"]
}
