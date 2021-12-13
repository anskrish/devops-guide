resource "aws_instance" "airflow" {
  ami                                  = var.ami
  availability_zone                    = var.availability_zone
  instance_type                        = var.instance_type
  disable_api_termination              = var.disable_api_termination
  user_data                            = var.user_data
  user_data_base64                     = var.user_data_base64
  iam_instance_profile                 = var.instance_profile
  associate_public_ip_address          = var.associate_public_ip_address
  key_name                             = var.key_name
  subnet_id                            = var.subnet_id
  monitoring                           = var.monitoring
  source_dest_check                    = var.source_dest_check

  vpc_security_group_ids = var.vpc_security_group_ids

  dynamic "root_block_device" {
    for_each = var.root_block_device
    content {
      delete_on_termination = lookup(root_block_device.value, "delete_on_termination", null)
      encrypted             = lookup(root_block_device.value, "encrypted", null)
      iops                  = lookup(root_block_device.value, "iops", null)
      kms_key_id            = lookup(root_block_device.value, "kms_key_id", null)
      volume_size           = lookup(root_block_device.value, "volume_size", null)
      volume_type           = lookup(root_block_device.value, "volume_type", null)
      throughput            = lookup(root_block_device.value, "throughput", null)
      tags                  = lookup(root_block_device.value, "tags", null)
    }
  }

  tags = var.tags
}


