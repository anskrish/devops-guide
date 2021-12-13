default, help::
	@echo "This Terraform is used to create/enable AWS Inspector for respective account/region.\n"
	@echo "USAGE:"
	@echo "$$ make <COMMAND> -e stack=<aws-account-name> -e stack_region=<aws-region>"

	@echo "AWS ACCOUNT ALIASES:"
	@echo " - krishna-account1"

	@echo "REGION ALIASES"
	@echo "us-east-1"
	@echo "us-west-2"

	@echo "\nCOMMANDS:"
	@echo " - set   : runs terraform init to create inspector module"
	@echo "- workspace-create : Create workspace for every account after init, ignore if you already created workspace for respective account."
	@echo " - workspace-switch : Switch to respective account workspace"
	@echo " - plan  : runs terraform plan to create resource for inspector"
	@echo " - apply : runs terraform apply to create inspector resource"
	@echo " - clean-inspector : Clean the .out and .terraform files"
	@echo " - destroy : destroy the resources under respective workspaces\n"
	@

all: set workspace-switch plan

set:
	rm -rf ./aws_inspector/.out ./aws_inspector/.terraform*
	terraform -chdir=./aws_inspector init
	terraform -chdir=./aws_inspector workspace show
	terraform -chdir=./aws_inspector workspace list
workspace-switch:
	terraform -chdir=./aws_inspector workspace select ${stack}-${stack_region}
	terraform -chdir=./aws_inspector workspace show

workspace-create:
	terraform -chdir=./aws_inspector workspace list
	terraform -chdir=./aws_inspector workspace new ${stack}-${stack_region}
	terraform -chdir=./aws_inspector workspace show

plan:
	terraform -chdir=./aws_inspector plan -var-file="../${stack}/${stack_region}/terraform.tfvars" -out=${stack}-${stack_region}-inspector-plan.out

apply:
	terraform -chdir=./aws_inspector apply ${stack}-${stack_region}-inspector-plan.out

@Intentionally commented to avoid accidental execution. This is just for reference how to destroy:
destroy:
	terraform -chdir=./aws_inspector destroy -var-file="../${stack}/${stack_region}/terraform.tfvars"

@delete-workspace:
@	terraform -chdir=./aws_inspector workspace select default
@	terraform -chdir=./aws_inspector workspace delete ${stack}-${stack_region}

clean-inspector:
	rm -rf ./aws_inspector/*.out ./aws_inspector/.terraform*
