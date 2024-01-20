# Variables
TF_DIR := ./devops
SPACE := service #cluster or services
ENVIRONMENT := dev
PLAN_OUTPUT := plan.out

init:
	cd $(TF_DIR)/$(SPACE) && terraform init

plan:
	cd $(TF_DIR)/$(SPACE) && terraform plan -out=$(PLAN_OUTPUT) -var-file=$(ENVIRONMENT).tfvars

apply:
	cd $(TF_DIR)/$(SPACE) && terraform apply $(PLAN_OUTPUT) 

destroy:
	cd $(TF_DIR)/$(SPACE) && terraform destroy -var-file=$(ENVIRONMENT).tfvars
