#!/usr/bin/env bash -eu

DIR=$(dirname ${BASH_SOURCE[0]})

kapp deploy -a nginx \
    -n default \
    --map-ns default=nginx \
    --map-ns nginx=nginx \
    --map-ns kube-system=kube-system \
    --kubeconfig-context dev \
    -f <(kapitan refs --reveal -f ${DIR})
