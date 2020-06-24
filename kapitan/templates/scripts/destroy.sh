#!/bin/bash -eu

DIR=$(dirname ${BASH_SOURCE[0]})
STACK="dev"
ENV="dev"

{% include "temp_dir.sh" %}

pulumi stack select ${STACK} -C "${tmp_dir}/deploy"

echo "Bringing up ${STACK} cluster..."
pulumi destroy -y -C "${tmp_dir}/deploy"