all:	set plan
set:
		rm -rf .terraform/terraform.tfstate .terraform*
		terraform init --backend-config="key=unit/dev/vpc/terraform.tfstate"

plan:
		terraform plan -out=aws-vpc.out

apply:
		terraform apply aws-vpc.out

clean:
		rm -f *.tfvars
		rm -f *.out
		rm -rf .terraform/*
