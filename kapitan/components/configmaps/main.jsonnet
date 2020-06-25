local kube = import "../../lib/kube/kube.libsonnet";
local kap = import "../../lib/kapitan/kapitan.libjsonnet";
local inventory = kap.inventory();
local p = inventory.parameters;

{
    [name]: kube.ConfigMap(name) {
        data: p.configmaps[name].data
    } for name in std.objectFields(p.configmaps)
}
