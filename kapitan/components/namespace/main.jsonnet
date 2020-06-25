local kap = import '../../lib/kapitan/kapitan.libjsonnet';
local kube = import '../../lib/kube/kube.libsonnet';
local inventory = kap.inventory();
local p = inventory.parameters;

{
  namespace: kube.Namespace(p.namespace),
}
