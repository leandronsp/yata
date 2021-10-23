import * as pulumi from "@pulumi/pulumi";
import * as gcp from "@pulumi/gcp";
import * as k8s from "@pulumi/kubernetes";

export const k8sCluster = new gcp.container.Cluster("yata-kubernetes", {
  initialNodeCount: 1,
  removeDefaultNodePool: true,
  location: "europe-central2-a",
});

const nodePool = new gcp.container.NodePool("primary-node-pool", {
  cluster: k8sCluster.name,
  initialNodeCount: 1,
  location: k8sCluster.location,
  nodeConfig: {
    preemptible: true,
    machineType: "n1-standard-1",
    oauthScopes: [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring"
    ],
  },
  management: {
    autoRepair: true,
    autoUpgrade: true,
  },
}, {
  dependsOn: [k8sCluster],
});

export const k8sConfig = pulumi.
  all([ k8sCluster.name, k8sCluster.endpoint, k8sCluster.masterAuth ]).
  apply(([ name, endpoint, auth ]) => {
    const context = `${gcp.config.project}_${gcp.config.zone}_${name}`;
    return `apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: ${auth.clusterCaCertificate}
    server: https://${endpoint}
  name: ${context}
contexts:
- context:
    cluster: ${context}
    user: ${context}
  name: ${context}
current-context: ${context}
kind: Config
preferences: {}
users:
- name: ${context}
  user:
    auth-provider:
      config:
        cmd-args: config config-helper --format=json
        cmd-path: gcloud
        expiry-key: '{.credential.token_expiry}'
        token-key: '{.credential.access_token}'
      name: gcp
`;
  });

export const k8sProvider = new k8s.Provider("gkeK8s", {
  kubeconfig: k8sConfig,
}, {
  dependsOn: [nodePool],
});
