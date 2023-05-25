#!/bin/bash

JOBNAME=$2
NAMESPACE=$1
OUTPUT=$3

kubectl create job $JOBNAME -n $NAMESPACE --image=busybox -- echo "$OUTPUT"
kubectl get job -n $NAMESPACE
kubectl get pods -n $NAMESPACE

exit 0