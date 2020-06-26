#!/usr/bin/env bash -eu

DIR=$(dirname ${BASH_SOURCE[0]})

kapp deploy -a nfs \
    -n default \
    --map-ns default=nfs \
    --map-ns nfs=nfs \
    --map-ns kube-system=kube-system \
    --kubeconfig-context dev \
    -f <(kapitan refs --reveal -f ${DIR})
