#!/usr/bin/env bash -eu

DIR=$(dirname ${BASH_SOURCE[0]})

kapp deploy -a {{ inventory.parameters.target_name }} \
    -n default \
    --map-ns default={{ inventory.parameters.namespace }} \
    --map-ns {{ inventory.parameters.namespace }}={{ inventory.parameters.namespace }} \
    --map-ns kube-system=kube-system \
    --kubeconfig-context {{ inventory.parameters.environment.context }} \
    -f <(kapitan refs --reveal -f ${DIR})
