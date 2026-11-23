output "web_url" {
  value = "https://${aws_cloudfront_distribution.web.domain_name}"
}

output "web_bucket" {
  value = aws_s3_bucket.web.bucket
}

output "cloudfront_distribution_id" {
  value = aws_cloudfront_distribution.web.id
}

output "ecs_cluster" {
  value = aws_ecs_cluster.main.name
}

output "ecs_api_service" {
  value = aws_ecs_service.api.name
}

output "api_subnet_ids" {
  value = module.vpc.public_subnets
}

output "api_security_group_id" {
  value = aws_security_group.api.id
}

output "documents_bucket" {
  value = aws_s3_bucket.documents.bucket
}

output "ingest_queue_url" {
  value = aws_sqs_queue.ingest.url
}