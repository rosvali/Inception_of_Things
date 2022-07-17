echo "########## Cleaning namespaces.. ##########"

kubectl delete namespace gitlab

echo "########## Creating namespaces.. ##########"

kubectl create namespace gitlab

echo "########## Installing gitlab.. ##########"

helm repo add gitlab https://charts.gitlab.io/
helm repo update

helm dependency update
helm install gitlab gitlab/gitlab \
  --namespace gitlab \
  --timeout 600s \
  -f /Users/rosvali/Projects/ioT/bonus/confs/gitlab-minimum-values.yaml

echo "########## Waiting for pods to be ready.. ##########"

kubectl wait --for=condition=Ready pods --all --timeout=-1s -n gitlab

echo "########## Apply ingress.. ##########"

kubectl apply -n gitlab -f /Users/rosvali/Projects/IoT/bonus/confs/ingress.yaml

echo "########## Get password for gitlab.. ##########"

password=$(kubectl get secret gitlab-gitlab-initial-root-password -n gitlab -o jsonpath='{.data.password}' | base64 --decode)

echo "########## Installation completed.. ##########"
echo "#############################################"
echo "########## Connect to Gitlab: ##########"
echo "########## http://gitlab.example.com/ ##########"
echo "##############################################################"
echo "########## Pseudo: root ##########"
echo "########## Password: $password ##########"
echo "##############################################################"
echo "########## Run this command after the application is set up ##########"
echo "########## kubectl port-forward -n gitlab svc/gitlab-webservice-default 8181:443 ##########"
echo "##############################################################"
