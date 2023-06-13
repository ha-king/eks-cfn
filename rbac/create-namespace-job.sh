#!/bin/bash

JOBNAME=$1
NAMESPACE=$2
OUTPUT=$3

kubectl create job $JOBNAME -n $NAMESPACE --image=busybox -- echo "$OUTPUT"
kubectl get job -n $NAMESPACE
kubectl get pods -n $NAMESPACE

exit 0