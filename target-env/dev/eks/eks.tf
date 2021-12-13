module "eks" {
  source = "../../../../modules/eks/."
  eks_cluster_name = "dev"
  enabled_cluster_log_types = ["authenticator", "audit", "controllerManager"]
  eks_cluster_subnets = ["subnet-xxxsdscfd4dc4b326", "subnet-xxds2f7c8a6", "subnet-0sdsb15dssd", "subnet-ds1d1109d63sdsds"]
  eks_cluster_iam_role = "dev-eks-cluster-servicerole"
  eks_cluster_workernode_name = "dev-ondemandworkernodes"
  eks_cluster_worker_iam_role = "dev-nodegroup-ondemandwork-nodeinstancerole"
  eks_cluster_worker_instance_type = ["t3a.large"]
  max_size = 3
  min_size = 1
  desired_size = 1
  disk_size = 100
  ssh_key_name = "systems-keys-krishna"
  template_name = "dev-template"
  nodegroup_type = "dev-eks-workloads"
}
