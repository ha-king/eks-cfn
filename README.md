# AWS Cloud9 - EKS Cluster Management 

## Setup AWS Cloud9 to Manage EKS

Note: `VPC subnet selected for Cloud9 must be publicly available`

1. Login AWS Console
2. Create new Cloud9 environment named "eks-management-env"
3. Allow Cloud9 environment setup to complete

## Update Cloud9 IAM Role permissions to allow AdministratorAccess
1. Use AWS Console and navigate to IAM -> Role -> AWSCloud9SSMAccessRole
2. Update existing role AWSCloud9SSMAccessRole by adding IAM permission policy AdministratorAccess

#### Setup Steps (CFN)
1. Open Cloud9 environment named "eks-management-env"
2. In Cloud9, open Preferences -> AWS Settings. Disable the "AWS Manage Temporary Credentials" toggle
2. In Cloud9, open a terminal session Clone the github repo for this project: ```git clone https://github.com/ha-king/eks-cfn.git```
3. `cd eks-cfn/`
4. `/bin/sh cfn/deploy.sh EKS-DEV us-east-1`
5. Visit CloudFormation service to view the stack status, until status value is CREATE_COMPLETE
6. `/bin/sh cloud9/install_kubectl.sh`
7. `/bin/sh update-kubeconfig.sh EKS-DEV us-east-1`
8.  Run the `kubectl get all -A` command to view all Kubernetes resources

#### Credits

Author: Tre King

Github: ha-king