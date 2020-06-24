#!/bin/bash -eu

DIR=$(dirname ${BASH_SOURCE[0]})
STACK="dev"
ENV="dev"

echo "Creating working directory..."
tmp_dir=$(mktemp -d -t kapitan-XXXXXXXXXX)
cp  "${DIR}/../../lib/deploy" "${tmp_dir}/deploy"
cp "${DIR}/../../lib/kubespray" "${tmp_dir}/kubespray"
cp "${DIR}/Pulumi.${ENV}.yaml" "${tmp_dir}/deploy"
pulumi stack select ${STACK} -C "${tmp_dir}/deploy"

echo "Bringing up ${STACK} cluster..."
pulumi destroy -y -C "${tmp_dir}/deploy"