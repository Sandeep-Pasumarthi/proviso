variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "env" {
  type = string
}

variable "api_image_tag" {
  type    = string
  default = "bootstrap"
}

locals {
  name = "proviso-${var.env}"
}