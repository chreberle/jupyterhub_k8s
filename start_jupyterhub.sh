# Bash script to launch Jupyterhub on Kubernetes cluster

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

