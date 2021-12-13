all:	set plan
set:
		rm -rf .terraform/terraform.tfstate .terraform/* *.out
		terraform init --backend-config="key=unit/dev/eks/terraform.tfstate"

plan:
		terraform plan -out=aws-eks.out

apply:
		terraform apply aws-eks.out

clean:
		rm -f *.tfvars
		rm -f *.out
		rm -rf .terraform/*

