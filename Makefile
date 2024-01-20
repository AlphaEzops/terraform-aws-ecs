# Variables
TF_DIR := ./devops
VAR_DIR := ../../vars
SPACE := service #cluster or services
ENVIRONMENT := dev
PLAN_OUTPUT := plan.out

init:
	cd $(TF_DIR)/$(SPACE) && terraform init

plan:
	cd $(TF_DIR)/$(SPACE) && terraform plan -out=$(PLAN_OUTPUT) -var-file=$(VAR_DIR)/$(ENVIRONMENT).tfvars

apply:
	cd $(TF_DIR)/$(SPACE) && terraform apply $(PLAN_OUTPUT) 

destroy:
	cd $(TF_DIR)/$(SPACE) && terraform destroy -var-file=$(VAR_DIR)/$(ENVIRONMENT).tfvars
