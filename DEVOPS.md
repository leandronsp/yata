## Yata Devops

### Requirements

- Google Cloud SDK
- kubectl
- Node v12+
- Pulumi

### Provisioning the infrastructure
```bash
# Create the cluster
gcloud auth application-default login
pulumi up

# Configure cluster controllers
make kubectl.nginx
make kubectl.certmanager
make kubectl.kubeseal

# Create application secrets
make kubectl.secrets.create name=pguser value=produser
make kubectl.secrets.create name=pgpassword value=prodpassword

# Apply resources
make kubectl.apply
```

### Deploying the application
```bash
# Build the image for release
make build.release

# Login to the registry
make gcloud.authtoken
make docker.login

# Push image to the registry
make docker.push

# Rollout application in the cluster
make deploy.rollout
```
