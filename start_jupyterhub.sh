# Bash script to launch Jupyterhub on Kubernetes cluster
kubectl --namespace kube-system create serviceaccount tiller
kubectl create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount=kube-system:tiller
helm init --service-account tiller --wait
kubectl patch deployment tiller-deploy --namespace=kube-system --type=json --patch='[{"op": "add", "path": "/spec/template/spec/containers/0/command", "value": ["/tiller", "--listen=localhost:44134"]}]'
helm version

sed -i 's/<RANDOM_HEX>/'"$( openssl rand -hex 32 )"'/g' config.yaml
sed -i 's/<DUMMY_PW>/'$DUMMYPW'/g' config.yaml

helm repo add jupyterhub https://jupyterhub.github.io/helm-chart/
helm repo update

RELEASE=jhub
NAMESPACE=jhub

helm upgrade --install $RELEASE jupyterhub/jupyterhub \
  --namespace $NAMESPACE  \
  --version=0.8.2 \
  --values config.yaml

# Auto completion
# kubectl config set-context $(kubectl config current-context) --namespace ${NAMESPACE:-jhub}

# Nice to know

# Get IP etc
#kubectl --namespace=jhub get svc proxy-public

# Get pods
# kubectl get pod --namespace jhub
# kubectl get service --namespace jhub

