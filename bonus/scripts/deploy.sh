path_conf=/home/roberto/Desktop/42/iot_rosa/bonus/confs/

echo "########## Cleaning namespaces.. ##########"
kubectl delete namespace gitlab

echo "########## Creating namespaces.. ##########"
kubectl create namespace gitlab

echo "########## Create Application.. ##########"

kubectl apply -n argocd -f $path_conf/application_gitlab.yaml
kubectl apply -n argocd -f $path_conf/project_gitlab.yaml

# echo "########## Installation completed.. ##########"
# echo "##############################################################"
# echo "########## Connect to Gitlab: ##########"
# echo "########## http://192.168.42.100:8181/ ##########"
# echo "##############################################################"
