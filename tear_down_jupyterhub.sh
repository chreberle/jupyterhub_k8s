RELEASE=jhub
NAMESPACE=jhub

helm delete $RELEASE --purge

kubectl delete namespace $NAMESPACE
