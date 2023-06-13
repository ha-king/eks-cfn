#!/bin/bash

EKS_CLUSTER_NAME=$1
AWS_REGION=$2

aws eks update-kubeconfig --name $EKS_CLUSTER_NAME --region $AWS_REGION

exit 0