#!/usr/bin/env bash

if [ -n "$AWS_BUCKET" ]; then
  cat << EOF > .s3cfg
[default]
access_key = ${AWS_ACCESS_KEY}
secret_key = ${AWS_SECRET_KEY}
EOF
  if [ -d lib ]; then
    s3cmd sync lib/ s3://${AWS_BUCKET}/lib/
  else
    mkdir -p lib
    cd lib
    s3cmd get --recursive s3://${AWS_BUCKET}/lib/
    cd ..
  fi
  rm .s3cfg
fi