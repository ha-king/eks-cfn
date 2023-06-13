#!/bin/bash

NAMESPACE=$1
EKSCLUSTER=$2
NAMESPACE_ROLE_ARN=$3
ROLE_YAML=default-role.yaml
BINDING_YAML=default-binding.yaml

kubectl create namespace $NAMESPACE
sed "s/NAMESPACE/$NAMESPACE/g" $ROLE_YAML > $NAMESPACE-role.yaml
kubectl apply -f $NAMESPACE-role.yaml
sed "s/NAMESPACE/$NAMESPACE/g" $BINDING_YAML > $NAMESPACE-binding.yaml
kubectl apply -f $NAMESPACE-binding.yaml
eksctl create iamidentitymapping --cluster $EKSCLUSTER --arn $NAMESPACE_ROLE_ARN --username k8s-$NAMESPACE-user

exit 0