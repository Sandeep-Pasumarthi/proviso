data "aws_caller_identity" "current" {}

data "aws_ecr_repository" "api" {
  name = "proviso-api"
}