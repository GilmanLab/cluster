local kap = import '../../lib/kapitan/kapitan.libjsonnet';
local kube = import '../../lib/kube/kube.libsonnet';
local inventory = kap.inventory();
local p = inventory.parameters;

{
  clusterissuer: {
    apiVersion: 'cert-manager.io/v1alpha2',
    kind: 'ClusterIssuer',
    metadata: {
      name: p.issuer.name,
    },
    spec: {
      acme: {
        email: p.issuer.acme.email,
        server: p.issuer.acme.server,
        privateKeySecretRef: {
          name: p.issuer.name + '-issuer-account-key',
        },
        solvers: [
          {
            dns01: {
              cloudflare: {
                email: p.issuer.cloudflare.email,
                apiTokenSecretRef: {
                  name: p.issuer.cloudflare.secret.name,
                  key: p.issuer.cloudflare.secret.key,
                },
              },
            },
          },
        ],
      },
    },
  },
}
