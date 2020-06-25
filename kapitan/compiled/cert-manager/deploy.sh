#!/usr/bin/env bash -eu

DIR=$(dirname ${BASH_SOURCE[0]})

kapp deploy -a cert-manager \
    -n default \
    --map-ns default=cert-manager \
    --map-ns cert-manager=cert-manager \
    --map-ns kube-system=kube-system \
    --kubeconfig-context kubernetes-admin@glab.dev \
    -f <(kapitan refs --reveal -f ${DIR})
