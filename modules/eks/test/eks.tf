module "eks" {
  source = "../."
  eks_cluster_name = "test"
  enabled_cluster_log_types = ["authenticator", "audit", "controllerManager"]
  eks_cluster_subnets = ["subnet-01467b134e", "subnet-04d4d67d62", "subnet-0a1ccab25c", "subnet-0bceeef8b98af"]
  eks_cluster_iam_role = "test-Eks-Cluster-ServiceRole"
  eks_cluster_workernode_name = "test-OnDemandWorkerNodes"
  eks_cluster_worker_iam_role = "eks-node-group-test"
  eks_cluster_worker_instance_type = ["m5.2xlarge"]
  max_size = 3
  min_size = 1
  desired_size = 1
  disk_size = 100
  ssh_key_name = "systems-key-pair"
  nodegroup_type = "test-eks-workloads2"
}

