path_conf=/home/roberto/Desktop/42/iot_rosa/bonus/confs/

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
  -f $path_conf/gitlab-minimum-values.yaml

echo "########## Waiting for pods to be ready.. ##########"

pod=$(kubectl get pods -o name -n gitlab | grep "gitlab-webservice")
kubectl -n gitlab wait $pod --for=condition=Ready --timeout=-1s

echo "########## Apply ingress.. ##########"

kubectl apply -n gitlab -f $path_conf/ingress.yaml

echo "########## Get password for gitlab.. ##########"

password=$(kubectl get secret gitlab-gitlab-initial-root-password -n gitlab -o jsonpath='{.data.password}' | base64 --decode)

echo "########## Installation completed.. ##########"
echo "#############################################"
echo "########## Run this command for access gitlab ##########"
echo "########## kubectl port-forward -n gitlab svc/gitlab-webservice-default 8181 ##########"
echo "##############################################################"
echo "########## Connect to Gitlab: ##########"
echo "########## http://gitlab.example.com/ ##########"
echo "##############################################################"
echo "########## Pseudo: root ##########"
echo "########## Password: $password ##########"
echo "##############################################################"
