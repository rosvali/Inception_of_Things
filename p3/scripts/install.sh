# path_conf=/Users/rosvali/Projects/IoT/p3/confs/
path_conf=/home/roberto/Desktop/42/iot_rosa/p3/confs

echo "########## Creating cluster.. ##########"

k3d cluster create iot-cluster -p 8080:80@loadbalancer

echo "########## Creating namespaces.. ##########"

kubectl create namespace argocd
kubectl create namespace dev

echo "########## Installing argocd.. ##########"

kubectl apply -n argocd -f $path_conf/argo.yaml

sleep 10

echo "########## Waiting for pods to be ready.. ##########"

# pod=$(kubectl get pod -o name -n argocd | grep "argocd-server")
# kubectl -n argocd wait $pod --for=condition=Ready --timeout=-1s

kubectl wait --for=condition=Ready pods --all --timeout=-1s -n argocd

echo "########## Apply ingress.. ##########"

kubectl apply -n argocd -f $path_conf/ingress.yaml

echo "########## Get password for argocd CLI.. ##########"

passwordsecret=$(kubectl get secret argocd-initial-admin-secret -n argocd -o yaml | grep "password: " | cut -b 13-)
password=$(echo $passwordsecret | base64 --decode)

echo "########## Configure application.. ##########"

kubectl apply -f $path_conf/application.yaml -n argocd
kubectl apply -f $path_conf/project.yaml -n argocd

echo "########## Installation completed.. ##########"
echo "#############################################"
echo "########## Connect to ArgoCD CLI: ##########"
echo "########## http://localhost:8080/argocd/ ##########"
echo "##############################################################"
echo "########## Pseudo: admin ##########"
echo "########## Password: $password ##########"
echo "##############################################################"
echo "########## Run this command after the application is set up ##########"
echo "########## kubectl port-forward -n dev svc/wil-playground 8888 ##########"
echo "##############################################################"
echo "########## Application: http://localhost:8888/ ##########"
