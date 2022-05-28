all: set plan

set:
	rm -f .terraform/terraform.tfstate
	terraform init

plan:
	terraform plan -out=plan.out

apply:
	terraform apply plan.out
	rm -f *.tfvars *.out

clean:
	rm -f *.tfvars
	rm -f *.out
	rm -rf .terraform

