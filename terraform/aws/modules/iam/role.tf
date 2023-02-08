locals {
  sub_conditions = tolist([
    for repo in var.github_repos : "repo:${repo}:*"
  ])
}

data "aws_iam_policy_document" "oidc_assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github.arn]
    }

    condition {
      test     = "ForAllValues:StringLike"
      variable = "${aws_iam_openid_connect_provider.github.url}:sub"
      values   = local.sub_conditions
    }
  }
}

resource "aws_iam_role" "oidc_role" {
  name               = "oidc_role"
  assume_role_policy = data.aws_iam_policy_document.oidc_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "oidc_role_policy" {
  role       = aws_iam_role.oidc_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
