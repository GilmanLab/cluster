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
pulumi up -y -C "${tmp_dir}/deploy"

echo "Copying sample inventory"
cp -r "${tmp_dir}/kubespray/inventory/sample" "${tmp_dir}/kubespray/inventory/${ENV}"

echo "Creating inventory file..."
pulumi stack output cluster -C "${tmp_dir}/deploy" | python inv.py > "${tmp_dir}/kubespray/inventory/${ENV}/inventory.ini"

echo "Configuring cluster..."
ansible-playbook -i "${tmp_dir}/kubespray/inventory/${ENV}/inventory.ini" --become --become-user=root "${tmp_dir}/kubespray/cluster.yml"