provider "aws" {
  region = "ap-northeast-1"

  default_tags {
    tags = {
      Environment = "dev"
      Owner       = "terraform"
    }
  }
}
