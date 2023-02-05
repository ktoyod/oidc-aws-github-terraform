# oidc-aws-github-terraform

OIDC プロバイダーと IAM ロールを作成するためのリポジトリ。

これらを作成する主な目的は GitHub Actions　によるデプロイを実行すること。

## 事前準備

初回のみ手動デプロイが必要になる。

```sh
make backend
make plan
make apply
```

上記によって作成された IAM ロールを `OIDC_ROLE_{環境名}` という名前で GitHub の Secrets に登録しておく。

## デプロイ

本リポジトリで作成した OIDC プロバイダーと IAM ロールを使って CICD を組んでいる。

事前準備が終わっていれば PR の作成、マージによってデプロイが可能。
