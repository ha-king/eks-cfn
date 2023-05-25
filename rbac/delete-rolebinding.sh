#!/bin/bash

NAMESPACE=$1
EKSCLUSTER=$2
ROLE_YAML=$3
BINDING_YAML=$4
NAMESPACE_ROLE_ARN=$5

kubectl delete -f $ROLE_YAML
rm -rf $ROLE_YAML
kubectl delete -f $BINDING_YAML
rm -rf $BINDING_YAML
kubectl delete namespace $NAMESPACE
eksctl delete iamidentitymapping --cluster $EKSCLUSTER --arn $NAMESPACE_ROLE_ARN

exit 0
