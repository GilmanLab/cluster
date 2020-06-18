#!/bin/bash -eu

KUBECTL="kubectl --context kubernetes-admin@glab.dev --namespace nfs"

${KUBECTL} $@