module "eks_cluster-prod" {
  source = "./module/."
  cluster_name = "test-prod-1"
  location = "us-west4-a"
  node_count = 5
  tags = ["krishna", "devops", "prod"]
}
