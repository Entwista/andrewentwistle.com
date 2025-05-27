#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Sync files to S3, making sure only current files exist
aws s3 sync . s3://andrewentwistle.com \
    --delete \
    --exclude ".git/*" \
    --exclude "deploy.sh"

# Invalidate CloudFront cache
aws cloudfront create-invalidation \
    --distribution-id ER35KLEWXYGA5 \
    --paths "/*"

echo "✅ Blog successfully deployed to s3://andrewentwistle.com and CloudFront cache invalidated"
