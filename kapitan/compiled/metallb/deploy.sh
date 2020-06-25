#!/usr/bin/env bash -eu

DIR=$(dirname ${BASH_SOURCE[0]})

kapp deploy -a metallb \
    -n default \
    --map-ns default=metallb-system \
    --map-ns metallb-system=metallb-system \
    --map-ns kube-system=kube-system \
    --kubeconfig-context kubernetes-admin@glab.dev \
    -f <(kapitan refs --reveal -f ${DIR})