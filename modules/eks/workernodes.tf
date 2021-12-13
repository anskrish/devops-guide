resource "aws_eks_node_group" "eks" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = var.eks_cluster_workernode_name
  node_role_arn   = aws_iam_role.eks-worker-nodes.arn
  subnet_ids      = var.eks_cluster_subnets
  instance_types = var.eks_cluster_worker_instance_type
  launch_template {
    id = aws_launch_template.default.id
    version = "$Default"
  }
  labels = {
    nodegroup-name = var.eks_cluster_workernode_name
    cluster-name = aws_eks_cluster.eks.name
    nodegroup-type = var.nodegroup_type
  }
  tags = {
    nodegroup-name = var.eks_cluster_workernode_name
    cluster-name = aws_eks_cluster.eks.name
  }
  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.eks-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks-AmazonEC2ContainerRegistryReadOnly,
  ]
}


resource "aws_iam_role" "eks-worker-nodes" {
  name = var.eks_cluster_worker_iam_role

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "eks-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks-worker-nodes.name
}

resource "aws_iam_role_policy_attachment" "eks-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks-worker-nodes.name
}

resource "aws_iam_role_policy_attachment" "eks-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks-worker-nodes.name
}

resource "aws_iam_role_policy" "policyAutoScaling" {
  name = "eksctl-Systems-nodegroup-OnDemandWorkerNodes-PolicyAutoScaling"
  role = aws_iam_role.eks-worker-nodes.name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "autoscaling:DescribeAutoScalingGroups",
                "autoscaling:DescribeAutoScalingInstances",
                "autoscaling:DescribeLaunchConfigurations",
                "autoscaling:DescribeTags",
                "autoscaling:SetDesiredCapacity",
                "autoscaling:TerminateInstanceInAutoScalingGroup",
                "ec2:DescribeLaunchTemplateVersions"
            ],
            "Resource": "*",
            "Effect": "Allow"
        }
    ]
})
}

resource "aws_iam_role_policy" "PolicyCertManagerChangeSet" {
  name = "eksctl-Systems-nodegroup-OnDemandWorkerNodes-PolicyCertManagerChangeSet"
  role = aws_iam_role.eks-worker-nodes.name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "route53:ChangeResourceRecordSets"
            ],
            "Resource": "arn:aws:route53:::hostedzone/*",
            "Effect": "Allow"
        }
    ]
})
}

resource "aws_iam_role_policy" "PolicyCertManagerGetChange" {
  name = "eksctl-Systems-nodegroup-OnDemandWorkerNodes-PolicyCertManagerGetChange"
  role = aws_iam_role.eks-worker-nodes.name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "route53:GetChange"
            ],
            "Resource": "arn:aws:route53:::change/*",
            "Effect": "Allow"
        }
    ]
})
}

resource "aws_iam_role_policy" "PolicyCertManagerHostedZones" {
  name = "eksctl-Systems-nodegroup-OnDemandWorkerNodes-PolicyCertManagerHostedZones"
  role = aws_iam_role.eks-worker-nodes.name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "route53:ListResourceRecordSets",
                "route53:ListHostedZonesByName"
            ],
            "Resource": "*",
            "Effect": "Allow"
        }
    ]
})
}

resource "aws_iam_role_policy" "PolicyEBS" {
  name = "eksctl-Systems-nodegroup-OnDemandWorkerNodes-PolicyEBS"
  role = aws_iam_role.eks-worker-nodes.name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "ec2:AttachVolume",
                "ec2:CreateSnapshot",
                "ec2:CreateTags",
                "ec2:CreateVolume",
                "ec2:DeleteSnapshot",
                "ec2:DeleteTags",
                "ec2:DeleteVolume",
                "ec2:DescribeAvailabilityZones",
                "ec2:DescribeInstances",
                "ec2:DescribeSnapshots",
                "ec2:DescribeTags",
                "ec2:DescribeVolumes",
                "ec2:DescribeVolumesModifications",
                "ec2:DetachVolume",
                "ec2:ModifyVolume"
            ],
            "Resource": "*",
            "Effect": "Allow"
        }
    ]
})
}

resource "aws_iam_role_policy" "PolicyEFS" {
  name = "eksctl-Systems-nodegroup-OnDemandWorkerNodes-PolicyEFS"
  role = aws_iam_role.eks-worker-nodes.name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "elasticfilesystem:*"
            ],
            "Resource": "*",
            "Effect": "Allow"
        }
    ]
})
}

resource "aws_iam_role_policy" "PolicyEFSEC2" {
  name = "eksctl-Systems-nodegroup-OnDemandWorkerNodes-PolicyEFSEC2"
  role = aws_iam_role.eks-worker-nodes.name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "ec2:DescribeSubnets",
                "ec2:CreateNetworkInterface",
                "ec2:DescribeNetworkInterfaces",
                "ec2:DeleteNetworkInterface",
                "ec2:ModifyNetworkInterfaceAttribute",
                "ec2:DescribeNetworkInterfaceAttribute"
            ],
            "Resource": "*",
            "Effect": "Allow"
        }
    ]
})
}

resource "aws_iam_role_policy" "PolicyExternalDNSChangeSet" {
  name = "eksctl-Systems-nodegroup-OnDemandWorkerNodes-PolicyExternalDNSChangeSet"
  role = aws_iam_role.eks-worker-nodes.name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "route53:ChangeResourceRecordSets"
            ],
            "Resource": "arn:aws:route53:::hostedzone/*",
            "Effect": "Allow"
        }
    ]
})
}

resource "aws_iam_role_policy" "PolicyExternalDNSHostedZones" {
  name = "eksctl-Systems-nodegroup-OnDemandWorkerNodes-PolicyExternalDNSHostedZones"
  role = aws_iam_role.eks-worker-nodes.name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "route53:ListHostedZones",
                "route53:ListResourceRecordSets",
                "route53:ListTagsForResource"
            ],
            "Resource": "*",
            "Effect": "Allow"
        }
    ]
})
}

resource "aws_iam_role_policy" "PolicyFSX" {
  name = "eksctl-Systems-nodegroup-OnDemandWorkerNodes-PolicyFSX"
  role = aws_iam_role.eks-worker-nodes.name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "fsx:*"
            ],
            "Resource": "*",
            "Effect": "Allow"
        }
    ]
})
}

resource "aws_iam_role_policy" "PolicyServiceLinkRole" {
  name = "eksctl-Systems-nodegroup-OnDemandWorkerNodes-PolicyServiceLinkRole"
  role = aws_iam_role.eks-worker-nodes.name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "iam:CreateServiceLinkedRole",
                "iam:AttachRolePolicy",
                "iam:PutRolePolicy"
            ],
            "Resource": "arn:aws:iam::*:role/aws-service-role/*",
            "Effect": "Allow"
        }
    ]
})
}
