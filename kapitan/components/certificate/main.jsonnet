local kap = import '../../lib/kapitan/kapitan.libjsonnet';
local kube = import '../../lib/kube/kube.libsonnet';
local inventory = kap.inventory();
local p = inventory.parameters;

{
  certificate: {
    apiVersion: 'cert-manager.io/v1alpha2',
    kind: 'Certificate',
    metadata: {
      name: p.certificate.name,
    },
    spec: {
      secretName: p.certificate.name + '-tls',
      commonName: p.certificate.common_name,
      dnsNames: p.certificate.dns_names,
      issuerRef: {
        name: p.certificate.issuer.name,
        kind: p.certificate.issuer.type,
      },
    },
  },
}
