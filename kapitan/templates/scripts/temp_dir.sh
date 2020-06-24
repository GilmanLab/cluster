echo "Creating working directory..."
tmp_dir=$(mktemp -d -t kapitan-XXXXXXXXXX)
cp  "${DIR}/../../lib/deploy" "${tmp_dir}/deploy"
cp "${DIR}/../../lib/kubespray" "${tmp_dir}/kubespray"
cp "${DIR}/Pulumi.${ENV}.yaml" "${tmp_dir}/deploy"