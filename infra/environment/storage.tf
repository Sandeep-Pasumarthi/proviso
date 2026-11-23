resource "aws_s3_bucket" "documents" {
  bucket        = "${local.name}-documents-${data.aws_caller_identity.current.account_id}"
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "documents" {
  bucket                  = aws_s3_bucket.documents.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_sqs_queue" "ingest_dlq" {
  name                      = "${local.name}-ingest-dlq"
  message_retention_seconds = 1209600
}

resource "aws_sqs_queue" "ingest" {
  name                       = "${local.name}-ingest"
  visibility_timeout_seconds = 300
  receive_wait_time_seconds  = 20

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.ingest_dlq.arn
    maxReceiveCount     = 3
  })
}