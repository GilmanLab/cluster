#!/bin/bash -eu

DIR=$(dirname ${BASH_SOURCE[0]})

for SECTION in manifests secrets configmaps
do
  echo "## run kubectl delete for ${SECTION}"
  kapitan refs --reveal -f ${DIR}/${SECTION}/ | ${DIR}/kubectl.sh delete -f - | column -t
done

if [[ -d ${DIR}/pre-deploy ]]; then
    echo "## run kubectl delete for pre-deploy"
    kapitan refs --reveal -f ${DIR}/pre-deploy/ | ${DIR}/kubectl.sh delete -f - | column -t
fi