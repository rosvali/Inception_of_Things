echo "create namespace for gitlab"
kubectl create namespace gitlab

helm repo add gitlab https://charts.gitlab.io/
helm repo update

# git clone https://gitlab.com/gitlab-org/charts/gitlab.git
cd gitlab

# helm dependency update
helm install gitlab . \
  --namespace gitlab \
  --timeout 600s \
  -f /Users/rosvali/Projects/ioT/bonus/confs/values-minikube-minimum.yaml

echo "wait until pods are ready"
# kubectl -n gitlab wait $pod --for=condition=Ready --timeout=-1s
# kubectl -n gitlab get pods -w

echo "Gitlab Deployed !"