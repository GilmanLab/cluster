#!/usr/bin/env bash

echo "Removing old token..."
rm refs/cloudflare-token

echo "Generating from new token..."
token=$(lpass show --sync=now GLab/Cloudflare --field=key | base64)
echo ${token} > cf
make secret path=cloudflare-token target=cert-manager secretfile=cf
rm cf

echo "Recompiling..."
make
