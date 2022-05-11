echo "########## Creating cluster.. ##########"

k3d cluster create iot-cluster -p 8080:80@loadbalancer

echo "########## Creating namespaces.. ##########"

kubectl create namespace argocd
kubectl create namespace dev

echo "########## Installing argocd.. ##########"

kubectl apply -n argocd -f argo.yaml

echo "########## Waiting pod to be ready.. ##########"

kubectl -n argocd wait pod argocd-application-controller-0 --for=condition=Ready --timeout=-1s

echo "########## Apply ingress.. ##########"

kubectl apply -n argocd -f ingress.yaml

echo "########## Get password for argocd CLI.. ##########"

passwordsecret=$(kubectl get secret argocd-initial-admin-secret -n argocd -o yaml | grep "password: " | cut -b 13-)
password=$(echo $passwordsecret | base64 --decode)

echo "########## Configure application.. ##########"

kubectl apply -f application.yaml -n argocd
kubectl apply -f project.yaml -n argocd

echo "########## Installation completed.. ##########"

echo "########## Argocd CLI: http://localhost:8080/argocd/ ##########"
echo "########## Pseudo: admin ##########"
echo "########## Password: $password ##########"
echo "########## Application: http://localhost:8888/ ##########"

kubectl port-forward -n dev svc/wil-playground-service 8888
