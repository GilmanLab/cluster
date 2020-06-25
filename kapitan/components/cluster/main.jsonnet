local kap = import '../../lib/kapitan/kapitan.libjsonnet';
local kube = import '../../lib/kube/kube.libsonnet';
local inventory = kap.inventory();
local p = inventory.parameters;

{
  ['Pulumi.' + p.env.name]: {
    config: {
      'glab:cluster': {
        masters: p.cluster.masters,
        name: p.cluster.name,
        nodes: p.cluster.nodes,
      },
      'glab:env': {
        datacenter: p.env.datacenter,
        domain: p.env.domain,
        network: {
          domains: p.env.network.domains,
          dns_servers: p.env.network.dns_servers,
          name: p.env.network.name,
          subnet: p.env.network.subnet,
        },
        name: p.env.name,
        node: {
          master: {
            name: p.env.node.master.name,
            network_offset: p.env.node.master.network_offset,
            cpus: p.env.node.master.cpus,
            memory: p.env.node.master.memory,
          },
          worker: {
            name: p.env.node.worker.name,
            network_offset: p.env.node.worker.network_offset,
            cpus: p.env.node.worker.cpus,
            memory: p.env.node.worker.memory,
          },
        },
        pools: p.env.pools,
        template: p.env.template,
        vault_address: p.env.vault_address,
      },
    },
  },
}
