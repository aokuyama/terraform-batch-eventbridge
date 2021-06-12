terraform {
  required_version = "~> 1.0.0"
}

provider "aws" {
  region = var.region
}

variable "region" {
  type    = string
  default = "ap-northeast-1"
}
