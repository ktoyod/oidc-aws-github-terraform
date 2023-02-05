terraform {
  backend "s3" {
    bucket = "oidc-aws-terraform-state-dev"
    key    = "terraform.tfstate"

    region = "ap-northeast-1"
  }
}
