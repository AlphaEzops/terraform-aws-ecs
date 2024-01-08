# Variables
TF_DIR := ./
PLAN_OUTPUT := plan.out
VAR_DIR := ./vars
ENVIRONMENT := dev

# Targets
init:
	cd $(TF_DIR) && terraform init

plan:
	cd $(TF_DIR) && terraform plan -out=$(PLAN_OUTPUT) -var-file=$(VAR_DIR)/$(ENVIRONMENT).tfvars

apply:
	cd $(TF_DIR) && terraform apply $(PLAN_OUTPUT) -var-file=$(VAR_DIR)/$(ENVIRONMENT).tfvars

destroy:
	cd $(TF_DIR) && terraform destroy -var-file=$(VAR_DIR)/$(ENVIRONMENT).tfvars


