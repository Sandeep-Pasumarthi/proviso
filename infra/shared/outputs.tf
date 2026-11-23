output "ecr_api_url" {
  value = aws_ecr_repository.app["api"].repository_url
}

output "ecr_worker_url" {
  value = aws_ecr_repository.app["worker"].repository_url
}