local kube = import "../../lib/kube/kube.libsonnet";
local kap = import "../../lib/kapitan/kapitan.libjsonnet";
local inventory = kap.inventory();
local p = inventory.parameters;

{
    [name]: kube.Secret(name) {
        data: p.secrets[name].data
    } for name in std.objectFields(p.secrets)
}