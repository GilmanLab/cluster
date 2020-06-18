#!/bin/bash -eu

KUBECTL="kubectl --context {{inventory.parameters.context}} --namespace {{inventory.parameters.target_name}}"

${KUBECTL} $@