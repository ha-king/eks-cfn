#!/bin/bash

JOBNAME=$1
NAMESPACE=$2

kubectl delete job $JOBNAME -n $NAMESPACE
kubectl get job -n $NAMESPACE
kubectl get pods -n $NAMESPACE

exit 0