## Prerequisites

* Requires terraform 0.12.20
* Amazon Inspector Agent and tags assigned on desired EC2 instances to scan.

## Usage

Note: Only EC2 instances with the AWS Inspector agent installed and desired tags assigned will be included on an assessment.


**1. Update main.tf as instructed in below**

1.1 Configure the backend bucket in main.tf

```
terraform {
  required_version = "= 0.12.20"
  backend "s3" {
    bucket = "krishna-terraform"
    region = "us-west-1"
  }
}
```

**2. Update the inspector.tf for below variable values based on your requirement.**

###update the below variable values ###

| Name | Description | Type | Default | Required
| ------ | ------ | ------ | ------ | ------ |
|*source*|*The source code for the desired module.*|*string*| |*Yes*|
|*name_prefix*|*Used as a prefix for resources created in AWS.*|*string*| |*Yes*|
|*enabled*|*A way to disable the entire module.*|*boolean*|*TRUE*| |
|*enable_scheduled_event*|*A way to disable Inspector from running on a schedule*|*boolean*|*TRUE*| |
|*schedule_expression*|*How often to run an Inspector assessment.*|*string*|*rate(90 days)*| |
|*assessment_duration*|*How long the assessment runs in seconds.*|*num*|*3600*| |
|*inspector_target_tags*|*Tags to identify target instances.*|*list*| |*Yes*|
|*inspector_rules_packages*|*Rules(scan types available) from AWS to run vulnerability assessment on target instances. You need to provide region specific rules package arn. Ref:https://docs.aws.amazon.com/inspector/latest/userguide/inspector_rules-arns.html*|*list*| |*Yes*|
|*tags*|*tags to assessment template*|*list*| |*Yes*|


### Example

<STACK_NAME> Should be replace with stack name like sandbox, qa, stage, nightly or prod


```terraform

module "inspector_<STACK_NAME>" {
  source = "../../."
  enabled = true
  name_prefix = "<STACK_NAME>"
  enable_scheduled_event = true
  schedule_expression = "rate(90 days)"
  assessment_duration = "3600"
  inspector_use_tags = {
    SecurityScan = "AWS-Inspector-<STACK_NAME>"
  }
  inspector_rules_packages = [
  "arn:aws:inspector:us-west-2:758058086616:rulespackage/0-9hgA516p",
  "arn:aws:inspector:us-west-2:758058086616:rulespackage/0-H5hpSawc",
  "arn:aws:inspector:us-west-2:758058086616:rulespackage/0-rD1z6dpl",
  "arn:aws:inspector:us-west-2:758058086616:rulespackage/0-JJOtZiqQ",
  ]
  tags = {
    team = "krishna-infra"
    environment = "<STACK_NAME>" 
    service = "aws-inspector" 
    version = "v1"
    Terraform = "true"
    Initiator = "Terraform"
}
}

```




3. Update Makefile 


**Example: Sample Makefile**

region = Replace with region 
account-number = replace with actual account number

```
all: set plan

set:
    rm -f .terraform/terraform.tfstate
    terraform init --backend-config="key=unit/{account-number}/aws_inspector_${region}/terraform.tfstate"
plan:
    terraform plan -out=aws_inspector_${region}.out

apply:
    terraform apply aws_inspector_${region}.out

clean:
    rm -f *.out

 ```
**#Step 3**: Execute the below steps.

Note: Assume the required account role and execute below steps.

- make all
- make apply





