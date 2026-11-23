output "ecr_api_url" {
  value = aws_ecr_repository.app["api"].repository_url
}

output "ecr_worker_url" {
  value = aws_ecr_repository.app["worker"].repository_url
}

output "github_deploy_role_arn" {
  value = aws_iam_role.github_deploy.arn
}