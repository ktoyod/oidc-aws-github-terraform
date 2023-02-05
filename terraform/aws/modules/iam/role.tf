locals {
  sub_conditions = tolist([
    for repo in var.github_repos : "repo:${repo}:*"
  ])
}

resource "aws_iam_role" "oidc_role" {
  name = "oidc_role"
  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Principal" : {
            "Federated" : aws_iam_openid_connect_provider.github.arn
          },
          "Action" : "sts:AssumeRoleWithWebIdentity",
          "Condition" : {
            "ForAllValues:StringLike" : {
              "${aws_iam_openid_connect_provider.github.url}:sub" : local.sub_conditions
            }
          }
        }
      ]
    }
  )
}

resource "aws_iam_role_policy_attachment" "oidc_role_policy" {
  role       = aws_iam_role.oidc_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
