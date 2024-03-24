
### Connect to AKS
```shell
az account set --subscription <subscription-id>
az aks get-credentials --resource-group <resource-group-name> --name <aks-name> --overwrite-existing
```

### Install Helm
```shell
brew install helm

```

### Install Jetstack
```shell
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --version v1.14.0 --set installCRDs=true

```

### Installing the Action Runner Controller
```shell
helm repo add actions-runner-controller https://actions-runner-controller.github.io/actions-runner-controller
helm repo update
helm upgrade --install --namespace actions-runner-system --create-namespace --set=authSecret.create=true --set=authSecret.github_token="<your-PAT>"  --wait actions-runner-controller actions-runner-controller/actions-runner-controller
```

### Check pods
```shell
kubectl get pods -A

```

### Start Runners
```shell
cd self-hosted
kubectl apply -f .\runner.yaml

```
