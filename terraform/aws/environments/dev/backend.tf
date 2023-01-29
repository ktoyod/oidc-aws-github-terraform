terraform {
  backend "s3" {
    bucket = "ktoyod-terraform-template-dev"
    key    = "terraform.tfstate" # Same as the default

    profile = "default"
    region  = "ap-northeast-1"
  }
}
