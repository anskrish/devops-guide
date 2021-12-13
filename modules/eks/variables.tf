variable "region" {
  description = "The target region"
  default = "us-east-1"
}

variable "eks_cluster_name" {
  description = "cluster name"
  default = "systems2"
}

variable "enabled_cluster_log_types" {
  description = "cluster log_types for cloudwatch"
  type = list(string)
}
variable "eks_cluster_subnets" {
  description = "cluster subnets"
  type = list(string)
  default = ["subnet-07951ce7a7535fff7", "subnet-0bce681e4c7e594c5"]
}

variable "eks_cluster_iam_role" {
  description = "cluster role name"
  default = "eks-cluster-role-systems2"
}

variable "eks_cluster_workernode_name" {
  description = "workernode name"
  default = "eks-workernodes-systems2"
}
variable "eks_cluster_workernode_jenkins_name" {
  description = "workernode name"
  default = "eks-workernodes-systems-jenkins-spot"
}
variable "eks_cluster_worker_iam_role" {
  description = "cluster role name"
  default = "eks-node-group-systems2"
}

variable "nodegroup_type" {
  description = "cluster nodegroup_type"
  default = "systems2-eks-workloads2"
}

variable "eks_cluster_worker_instance_type" {
  description = "instance type"
  type = list(string)
  default = ["t3.medium", "t2.micro", "t2.medium"]
}

variable "disk_size" {
  description = "instance type"
  default = 25
}

variable "ssh_key_name" {
  description = "instance type"
  default = "systems-key-pair"
}

variable "eks_endpoint_private_access" {
  default = true
}
variable "eks_endpoint_public_access" {
  default = false
}
variable "max_size" {
  description = "instance type"
  default = 8
}

variable "min_size" {
  description = "instance type"
  default = 1
}

variable "desired_size" {
  description = "instance type"
  default = 1
}

variable "template_name" {
  default = "eks_template"
}