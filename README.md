# AWS Cloud9 - EKS Cluster Management 

## Setup AWS Cloud9 to Manage EKS

### Prerequisite:
1. Deploy VPC via CloudFormation template located in this repo: `cfn/vpc-2az.yaml`
2. CloudFormation stack name must be `vpc-2az`

Note: `VPC subnet selected for Cloud9 must be publicly available`

1. Login AWS Console
2. Create new Cloud9 environment named "eks-management-env"
3. Allow Cloud9 environment setup to complete

## Update Cloud9 IAM Role permissions to allow AdministratorAccess
1. Use AWS Console and navigate to IAM -> Role -> AWSCloud9SSMAccessRole
2. Update existing role AWSCloud9SSMAccessRole by adding IAM permission policy AdministratorAccess

#### Setup - (CloudFormation)
1. Open Cloud9 environment named "eks-management-env"
2. In Cloud9, open Preferences -> AWS Settings. Disable the "AWS Manage Temporary Credentials" toggle
2. In Cloud9, open a terminal session Clone the github repo for this project:
```
git clone https://github.com/ha-king/eks-cfn.git
```
3. `cd eks-cfn/cfn`
4. `/bin/sh deploy.sh EKS-DEV us-east-1`
5. Visit CloudFormation service to view the stack status, until status value is CREATE_COMPLETE
6. `cd ../cloud9`
6. `/bin/sh install_kubectl.sh`
7. `/bin/sh update-kubeconfig.sh EKS-DEV us-east-1`
8.  Run the `kubectl get all -A` command to view all Kubernetes resources

Clean up:
```
aws cloudformation delete-stack --stack-name EKS-DEV 
```

#### Setup - (Terraform)
1. Open Cloud9 environment named "eks-management-env"
2. In Cloud9, open Preferences -> AWS Settings. Disable the "AWS Manage Temporary Credentials" toggle
2. In Cloud9, open a terminal session Clone the github repo for this project:
```
git clone https://github.com/ha-king/eks-cfn.git
```
3. `cd eks-cfn/tf`
4. `/bin/sh deploy.sh`
5. `cd ../cloud9`
6. `/bin/sh install_kubectl.sh`
7. `/bin/sh update-kubeconfig.sh EKS-DEV-TF us-east-1`
8.  Run the `kubectl get all -A` command to view all Kubernetes resources

Clean up:
```
cd tf
terraform destroy --auto-approve
```

#### Sharing Cloud9 Environment
1. To invite an IAM user, enter arn:aws:iam::123456789012:user/MyUser. Replace 123456789012 with your AWS account ID and replace MyUser with the name of the user.
2. To invite a user with an assumed role or a federated user with an assumed role, enter arn:aws:sts::123456789012:assumed-role/MyAssumedRole/MyAssumedRoleSession.
3. To invite the AWS account root user, enter arn:aws:iam::123456789012:root. Replace 123456789012 with your AWS account ID.
##### Example:
```
aws cloud9 create-environment-membership --environment-id 1234567890987654321 --user-arn arn:aws:iam::123456789098:root --permissions read-write
```

#### Setup - EKS Admin IAM entities
1. `kubectl edit cm/aws-auth -n kube-system`
2. Reference the aws-auth configuration map below:
```
# Please edit the object below. Lines beginning with a '#' will be ignored,
# and an empty file will abort the edit. If an error occurs while saving this file will be
# reopened with the relevant failures.
#
apiVersion: v1
data:
  mapRoles: |
    - groups:
      - system:bootstrappers
      - system:nodes
      rolearn: arn:aws:iam::123456789098:role/eks-dev-EksNodeWorkerRole-123456789
      username: system:node:{{EC2PrivateDNSName}}
    - groups:
      - system:masters
      rolearn: arn:aws:iam::123456789098:role/eks-dev-EksRbacAdminRole-123456789
      username: ec2-admin
    - groups:
      - system:masters
      rolearn: arn:aws:iam::123456789098:role/my-role-name
      username: cre-admin
  mapUsers: |
    - groups:
      - system:masters
      userarn: arn:aws:iam::123456789098:user/my-user
      username: my-user
kind: ConfigMap
metadata:
  creationTimestamp: "2023-05-25T17:32:16Z"
  name: aws-auth
  namespace: kube-system
  resourceVersion: "21552"
  uid: 13e8d1d3-c6a1-4369-aff8-e58e94572ad3
```

#### EKS RBAC Setup

Prerequisite: `Create an IAM Role for this purpose`

Notes: `This Cloudformation deployment for EKS cluster also creates an EC2 Instance profile, see the Resources tab of CloudFormation`

1. `cd rbac`
2. `/bin/sh create-rolebindings.sh NAMESPACE EKSCLUSTER NAMESPACE_ROLE_ARN`

#### EKS RBAC Cleanup
1. `cd rbac`
1. `/bin/sh delete-rolebindings.sh NAMESPACE EKSCLUSTER ROLE_YAML BINDING_YAML NAMESPACE_ROLE_ARN`

#### References:
1. https://docs.aws.amazon.com/eks/latest/userguide/service_IAM_role.html#create-service-role
1. https://docs.aws.amazon.com/prescriptive-guidance/latest/patterns/deploy-an-amazon-eks[…]-cluster-from-aws-cloud9-using-an-ec2-instance-profile.html
1. https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html
1. https://docs.aws.amazon.com/cloud9/latest/user-guide/share-environment.html#share-environment-admin-user
1. https://repost.aws/knowledge-center/eks-iam-permissions-namespaces

#### Credits

Author: Tre King

Github: ha-king