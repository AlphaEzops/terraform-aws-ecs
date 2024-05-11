TF_DIR := ./devops
SPACE := cluster
ENVIRONMENT := dev
PLAN_OUTPUT := plan.out


init: ## Initialize terraform
	@cd $(TF_DIR)/$(SPACE) && terraform init

plan: ## Create a terraform plan
	@cd $(TF_DIR)/$(SPACE) && terraform plan -out=$(PLAN_OUTPUT) -var-file=../vars/$(ENVIRONMENT).tfvars

show: ## Show the terraform plan
	@cd $(TF_DIR)/$(SPACE) && terraform show -json $(PLAN_OUTPUT) >> $(PLAN_OUTPUT).json

apply: ## Apply the terraform plan
	@cd $(TF_DIR)/$(SPACE) && terraform apply $(PLAN_OUTPUT) 

destroy: ## Destroy the terraform plan
	@cd $(TF_DIR)/$(SPACE) && terraform destroy -var-file=../vars/$(ENVIRONMENT).tfvars

set_env: ## Change the value of SPACE variable
	@read -p "Enter the new value for SPACE (cluster or services): " input && \
	sed -i 's/SPACE := cluster/SPACE := '"$$input"'/g' Makefile

remove_tf_vars:
	@echo remove all .terraform folders...
	@find devops modules -type f \( -name ".terraform" -o -name ".terraform.lock.hcl" \) -exec rm -rf {} \;

help:
	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)
