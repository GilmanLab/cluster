#!/bin/bash -eu

KUBECTL="kubectl --context {{inventory.parameters.environment.context}} --namespace {{inventory.parameters.namespace}}"

${KUBECTL} $@