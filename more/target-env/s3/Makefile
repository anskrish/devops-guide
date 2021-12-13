all: set plan

set:
	rm -f .terraform/terraform.tfstate
	terraform init

plan:
	terraform plan -out=s3-bucket.out

apply:
	terraform apply s3-bucket.out
	rm -f *.tfvars *.out

clean:
	rm -f *.tfvars
	rm -f *.out



