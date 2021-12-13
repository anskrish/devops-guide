resource "aws_launch_template" "default" {
  name_prefix            = var.template_name
  description            = "Launch-Template"
  key_name = var.ssh_key_name
  update_default_version = true
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size           = var.disk_size
      volume_type           = "gp3"
    }
  }
  vpc_security_group_ids = [aws_eks_cluster.eks.vpc_config[0].cluster_security_group_id]
}
