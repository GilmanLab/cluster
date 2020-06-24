#!/bin/bash -eu

DIR=$(dirname ${BASH_SOURCE[0]})
STACK="{{ inventory.parameters.cluster.stack }}"
ENV="{{ inventory.parameters.env.name }}"

{% include "temp_dir.sh" %}

pulumi stack select ${STACK} -C "${tmp_dir}/deploy"

echo "Destroying ${STACK} cluster..."
pulumi destroy -y -C "${tmp_dir}/deploy"