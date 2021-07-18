# aws-inspector

This project is using Terraform workspaces to manage aws inspector in different accounts/regions.

# How to use

If you want to provision aws-inspector on specific region/account. then follow below steps

1. Create tfvars for respective account/region.

```
mkdir -p <aws-account-name>/<aws-region>
vim terraform.tfvars
```
Ex:

```
vim terraform.tfvars

region = "us-west-2"
inspector_enabled = true
name_prefix = "krishna-account1-us-west-2"
enable_scheduled_event = true
schedule_expression = "cron(0 6 1 * ? *)"
assessment_duration = "3600"
inspector_use_tags = {
    SecurityScan = "aws-inspector-krishna-account1-us-west-2"
  }
inspector_rules_packages = [
    "arn:aws:inspector:us-west-2:758058086616:rulespackage/0-9hgA516p",
    "arn:aws:inspector:us-west-2:758058086616:rulespackage/0-H5hpSawc",
    "arn:aws:inspector:us-west-2:758058086616:rulespackage/0-rD1z6dpl",
  ]
tags = {
    Contact = "krishna"
    Environment = "krishna-account1"
    Initiator = "Terraform"
  }

```
**Note: Make sure you are using appropriate region specfic ARNs while defining inspector_rules_packages**

# How statefile stores

-  It stores the terraform state file on S3 bucket as a backend.

-  In S3 bucket, terraform workspace state files are stored under "env" folder. Inside "env" folder, it will create folder for each workspace and then subsequently each workspace folder stores "unit/aws_inspector/terraform.tfstate"

Ex:

```
s3://krishna-terraform/env:/krishna-account1-us-west-2/unit/aws_inspector/terraform.tfstate
```

# How to execute

1. First initialize the S3 bucket

```
make set
```
2. Create workspace for our new account/region

- If you have already created workspace earlier, please skip this step and move to next step.
- Workspace name is everything before the .tfvars.( For example: I have tfvar file for account/region is configured as krishna-account1-us-west-2.tfvars, therefore my workspace name is "krishna-account1-us-west-2")


```
make workspace-create -e stack="<aws-account-name>" -e stack_region="<aws-region>"

```

Ex:

```
make workspace-create -e stack="krishna-account1" -e stack_region="us-west-2"

```

3. Switch to target workspace.

**Note:** If you have created workspace as instructed in above step (# step 2), then please skip this step and move to the next step.

```
make workspace-switch -e stack="<aws-account-name>" -e stack_region="<aws-region>"

```

Ex:

```
make workspace-switch -e stack="krishna-account1" -e stack_region="us-west-2"
```

4. Run terraform plan for the target account/region

```
make plan  -e stack="<aws-account-name>" -e stack_region="<aws-region>"

```

Ex:

```
make plan -e stack="krishna-account1" -e stack_region="us-west-2"
```

5. Apply the Plan for the target account/region

```
make apply  -e stack="<aws-account-name>" -e stack_region="<aws-region>"
```

Ex:

```
make apply -e stack="krishna-account1" -e stack_region="us-west-2"
```


# How to destroy the specific account/region resources

1. First initialize the S3 bucket

```
make set
```

2. Switch to target workspace.


```
make workspace-switch -e stack="<aws-account-name>" -e stack_region="<aws-region>"

```

Ex:

```
make workspace-switch -e stack="krishna-account1" -e stack_region="us-west-2"
```

3. Destroy the resources

```
make destroy -e stack="<aws-account-name>" -e stack_region="<aws-region>"

```
