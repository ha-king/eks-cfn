## EKS Management via RBAC

#### Setup - EKS Admin IAM entities
2. `kubectl edit cm/aws-auth -n kube-system`
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

1. `cd ../cloud9`
2. `/bin/sh install_eksctl.sh`
1. `cd ../rbac`
2. `/bin/sh create-rolebindings.sh NAMESPACE EKSCLUSTER NAMESPACE_ROLE_ARN`

#### EKS RBAC Cleanup
1. `cd rbac`