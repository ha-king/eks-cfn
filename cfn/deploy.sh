#!/bin/bash

STACKNAME=$1
AWS_REGION=$2

aws cloudformation create-stack \
  --stack-name $STACKNAME \
  --template-body file://eks-cfn.yaml \
  --region $AWS_REGION \
  --capabilities CAPABILITY_IAM

exit 0