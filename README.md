# AWS Cloud9 - EKS Cluster Management 

## Setup AWS Cloud9 to Manage EKS
1. Login AWS Console
2. Create new Cloud9 environment named "eks-management-env"
3. Allow Cloud9 environment setup to complete

## Update Cloud9 IAM Role permissions to allow AdministratorAccess
1. Use AWS Console and navigate to IAM -> Role -> AWSCloud9SSMAccessRole
2. Update existing role AWSCloud9SSMAccessRole by adding IAM permission policy AdministratorAccess

#### Setup Steps
1. Open Cloud9 environment named "eks-management-env"
2. In Cloud9, open a terminal session Clone the github repo for this project `git clone https://github.com/ha-king/eks-cfn.git`
3. `cd eks-cfn/cfn`
4. `/bin/sh deploy.sh EKS-DEV us-east-1`

#### Credits
Author: Tre King
Github: ha-king