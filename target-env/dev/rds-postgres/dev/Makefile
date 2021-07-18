all:	set plan
set:
		rm -rf .terraform/terraform.tfstate .terraform/*
		terraform init --backend-config="key=unit/dev/rds-postgree/terraform.tfstate"
		terraform init

plan:
		terraform plan -out=aws-rds-postgress.out

apply:
		terraform apply aws-rds-postgress.out

clean:
		rm -f *.tfvars
		rm -f *.out
		rm -rf .terraform/*

