#!/bin/bash

set -eux

region="ap-northeast-1"
bucket_name="ktoyod-terraform-template-dev"

aws s3api create-bucket \
  --bucket ${bucket_name} \
  --region ${region} \
  --create-bucket-configuration LocationConstraint=${region}

aws s3api put-bucket-versioning \
  --bucket ${bucket_name} \
  --versioning-configuration Status=Enabled

aws s3api put-bucket-encryption \
  --bucket ${bucket_name} \
  --server-side-encryption-configuration '{
    "Rules": [
      {
        "ApplyServerSideEncryptionByDefault": {
          "SSEAlgorithm": "AES256"
        }
      }
    ]
}'

aws s3api put-public-access-block \
  --bucket ${bucket_name} \
  --public-access-block-configuration '{
    "BlockPublicAcls": true,
    "IgnorePublicAcls": true,
    "BlockPublicPolicy": true,
    "RestrictPublicBuckets": true
}'
