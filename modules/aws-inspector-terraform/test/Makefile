TERRAFORM=terraform

all: apply

apply: 
	$(TERRAFORM) init
	$(TERRAFORM) apply

clean:
	$(TERRAFORM) init
	$(TERRAFORM) destroy
	rm -fr .terraform terraform.tfstate terraform.tfstate.backup
