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

variable "github_repository" {
  type    = string
  default = "Sandeep-Pasumarthi/proviso"
}