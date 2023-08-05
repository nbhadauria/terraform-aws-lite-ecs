resource "aws_s3_bucket" "this" {
  count = var.create_s3_bucket ? 1 : 0
  bucket = var.s3_bucket_name
}

resource "aws_s3_bucket_acl" "this" {
  count = var.create_s3_bucket ? 1 : 0
  bucket = aws_s3_bucket.this[0].id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "this" {
  count = var.create_s3_bucket ? 1 : 0
  bucket = aws_s3_bucket.this[0].id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}