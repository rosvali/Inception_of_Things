# Create cluster

k3d cluster create iot-cluster --api-port 6443 -p 8080:80@loadbalancer

# Create namespaces

kubectl create namespace argocd
kubectl create namespace dev

# Install argocd in argocd namespace

kubectl apply -n argocd -f argo.yaml

# Waiting pod to be ready

kubectl -n argocd wait pod argocd-application-controller-0 --for=condition=Ready --timeout=-1s

# Apply Argocd's ingress

kubectl apply -n argocd -f ingress.yaml

# Get password for login Argocd CLI

# passwordsecret="kubectl get secret argocd-initial-admin-secret -n argocd -o yaml | grep "password: " | cut -b 13-"
# echo $PASSWORDSECRET
# $PASSWORD=$(echo $PASSWORD | base64 --decode)
# ECHO $PASSWORD

# Login argocd CLI

# argocd login localhost --username admin --password $password
