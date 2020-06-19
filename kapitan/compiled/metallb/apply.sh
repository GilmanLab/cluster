#!/bin/bash -eu

DIR=$(dirname ${BASH_SOURCE[0]})

if [[ -d ${DIR}/pre-deploy ]]; then
    echo "## run kubectl apply for pre-deploy"
    kapitan refs --reveal -f ${DIR}/pre-deploy/ | ${DIR}/kubectl.sh apply -f - | column -t
fi

sleep 2

for SECTION in manifests secrets configmaps
do
  echo "## run kubectl apply for ${SECTION}"
  kapitan refs --reveal -f ${DIR}/${SECTION}/ | ${DIR}/kubectl.sh apply -f - | column -t
done