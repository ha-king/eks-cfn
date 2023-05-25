#!/bin/bash

JOBNAME=$2
NAMESPACE=$1
OUTPUT=$3

kubectl delete job $JOBNAME -n $NAMESPACE
kubectl get job -n $NAMESPACE
kubectl get pods -n $NAMESPACE

exit 0