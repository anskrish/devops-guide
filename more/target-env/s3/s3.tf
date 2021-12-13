module "s3_bucket" {
  source = "../../modules/S3/."
  bucket = local.bucket_name
  acl = "private"
  force_destroy = true
  attach_policy = true
  policy = data.aws_iam_policy_document.bucket_policy.json
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  versioning = {
    enabled = true
  }
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        kms_master_key_id = aws_kms_key.objects.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }
  tags = {
    Owner = "Pusha"
    Service = "S3"
  }
}

