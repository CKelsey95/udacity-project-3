#!/bin/bash
if [[ "$AWS_BUCKET" == arn:* ]]; then
    BUCKET="${AWS_BUCKET##*:}"

elif [[ "$AWS_BUCKET" == s3://* ]]; then
    BUCKET="${AWS_BUCKET#s3://}"
    BUCKET="${BUCKET%%/*}"

else
    BUCKET="$AWS_BUCKET"
fi

aws s3 cp --recursive --acl public-read ./www s3://$BUCKET
aws s3 cp --acl public-read --cache-control="max-age=0, no-cache, no-store, must-revalidate" ./www/index.html s3://$BUCKET