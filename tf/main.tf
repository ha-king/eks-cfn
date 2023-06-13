resource "aws_cloudformation_stack" "eks-cluster" {
  name = "eks-cluster-tf"
  parameters = {
    ParentVPCStack="vpc-2az"
    ClusterName="EKS-DEV-TF"
    EksVersion = "1.23"
    KeyName = "eks-workers"
    InstanceType = "t3.medium"
  }
  template_body = "${file("../cfn/eks-cfn.yaml")}"
  capabilities = ["CAPABILITY_IAM"]
}