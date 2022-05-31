## Create gitlab namespace

kubectl create namespace gitlab

## Deploy Gitlab with helm

helm repo add gitlab https://charts.gitlab.io/
helm repo update

helm upgrade --install gitlab gitlab/gitlab \
  --timeout 600s \
  --set global.hosts.domain=localhost \
  --set certmanager-issuer.email=me@example.com \
  --namespace gitlab