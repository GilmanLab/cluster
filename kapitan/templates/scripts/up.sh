#!/bin/bash -eu

DIR=$(dirname ${BASH_SOURCE[0]})
STACK="{{ inventory.parameters.cluster.stack }}"
ENV="{{ inventory.parameters.env.name }}"

{% include "temp_dir.sh" %}

pulumi stack select ${STACK} -C "${tmp_dir}/deploy"

echo "Bringing up ${STACK} cluster..."
#pulumi up -y -C "${tmp_dir}/deploy"

echo "Copying sample inventory"
cp -r "${tmp_dir}/kubespray/inventory/sample" "${tmp_dir}/kubespray/inventory/${ENV}"

echo "Creating inventory file..."
pulumi stack output cluster -C "${tmp_dir}/deploy" | python ${tmp_dir}/deploy/inv.py > "${tmp_dir}/kubespray/inventory/${ENV}/inventory.ini"

echo "Configuring cluster..."
EXTRA_VARS="{% for key, value in inventory.parameters.cluster.extra_vars.items() %}{{ key }}={{ value}} {% endfor %}"
EXTRA_VARS="${EXTRA_VARS}cluster_name='{{ inventory.parameters.cluster.name }}'"
ansible-playbook -i "${tmp_dir}/kubespray/inventory/${ENV}/inventory.ini" --extra-vars="${EXTRA_VARS}" --become --become-user=root "${tmp_dir}/kubespray/cluster.yml"

echo "Cleaning up..."
#rm -rf ${tmp_dir}