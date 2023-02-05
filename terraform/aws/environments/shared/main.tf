terraform {
  required_version = "~> 1.3.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}


module "iam" {
  source = "../../modules/iam"

  github_repos = var.github_repos
}
