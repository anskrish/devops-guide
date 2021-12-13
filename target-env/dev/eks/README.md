This script will help us to create a EKS cluster with nodegroup.

**Dependency**

  1. Access to github devops repo
  2. AWS credentials
  3. Terraform 0.14.3
  4. S3 bucket

| Tools | Description | Required
| ------ | ------ | ------ |
| AWSCLI | Configure cli with access and secret keys | yes |
| Terraform | Install terraform version 0.14.3 | yes |
| S3 | Create S3 bucket to store statefile | yes |

**Steps** 

**Step 1**. make all

**Step 2**. Review the plan

**Step 3**  make apply


**Validation**: 

  1. Login to AWS and check the resources and connection.

**Cluster access**
If you want to provide cluster access to any IAM user, Please follow below steps.

  1. aws eks --region us-east-1 update-kubeconfig --name dev
  2. update aws-auth-cm.yaml file new user IAM user arn and user name.
  3. Apply the changes
  kubectl apply -f aws-auth-cm.yaml 
