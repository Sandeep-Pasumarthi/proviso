variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "budget_email" {
  type = string
}

variable "monthly_budget_usd" {
  type    = number
  default = 20
}

variable "github_oidc_repo" {
  description = "Repository part of GitHub's OIDC sub claim: owner@owner_id/repo@repo_id"
  type        = string
  default     = "Sandeep-Pasumarthi@80049188/proviso@1467450977"
}