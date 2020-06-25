#!/usr/bin/env bash -eu

DIR=$(dirname ${BASH_SOURCE[0]})
STACK="dev"
ENV="dev"

echo "Creating working directory..."
tmp_dir=$(mktemp -d -t kapitan-XXXXXXXXXX)
cp -r "${DIR}/../../../lib/deploy" "${tmp_dir}/deploy"
cp -r "${DIR}/../../../lib/kubespray" "${tmp_dir}/kubespray"
cp "${DIR}/Pulumi.${ENV}.yaml" "${tmp_dir}/deploy"
pulumi stack select ${STACK} -C "${tmp_dir}/deploy"

echo "Bringing up ${STACK} cluster..."
pulumi up -y -C "${tmp_dir}/deploy"

echo "Copying sample inventory"
cp -r "${tmp_dir}/kubespray/inventory/sample" "${tmp_dir}/kubespray/inventory/${ENV}"

echo "Creating inventory file..."
pulumi stack output cluster -C "${tmp_dir}/deploy" | python ${tmp_dir}/deploy/inv.py > "${tmp_dir}/kubespray/inventory/${ENV}/inventory.ini"

echo "Configuring cluster..."
EXTRA_VARS="kube_proxy_strict_arp=True "
EXTRA_VARS="${EXTRA_VARS}cluster_name='glab.dev'"
ansible-playbook -i "${tmp_dir}/kubespray/inventory/${ENV}/inventory.ini" --extra-vars="${EXTRA_VARS}" --become --become-user=root "${tmp_dir}/kubespray/cluster.yml"

echo "Cleaning up..."
rm -rf ${tmp_dir}