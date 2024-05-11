TF_DIR := ./devops
ENVIRONMENT := dev
PLAN_OUTPUT := plan.out
TERRAFORM_OR_OPENTOFU := terraform

#===============================================================================
# INFRA AS CODE
#===============================================================================
init: ## Initialize terraform
	@cd $(TF_DIR) && $(TERRAFORM_OR_OPENTOFU) init

plan: ## Create a terraform plan
	@cd $(TF_DIR) && $(TERRAFORM_OR_OPENTOFU) plan -out=$(PLAN_OUTPUT) -var-file=../vars/$(ENVIRONMENT).tfvars

show: ## Show the terraform plan
	@cd $(TF_DIR) && $(TERRAFORM_OR_OPENTOFU) show -json $(PLAN_OUTPUT) >> $(PLAN_OUTPUT).json

apply: ## Apply the terraform plan
	@cd $(TF_DIR) && $(TERRAFORM_OR_OPENTOFU) apply $(PLAN_OUTPUT) 

destroy: ## Destroy the terraform plan
	@cd $(TF_DIR) && $(TERRAFORM_OR_OPENTOFU) destroy -var-file=../vars/$(ENVIRONMENT).tfvars

#===============================================================================
# SET ENVIRONMENT
#===============================================================================
get_current_info:
	@echo "IaC type: $(TERRAFORM_OR_OPENTOFU)" 
	@echo "Environment: $(ENVIRONMENT)"

set_terraform_type: ## SET the value of Terraform type
	@read -p "Enter the new value for  (terraform or tofu): " type && \
	sed -i 's/TERRAFORM_OR_OPENTOFU := terraform/TERRAFORM_OR_OPENTOFU := '"$$type"'/g' Makefile

set_enviroment: ## SET the value of ENVIRONMENT variable
	@read -p "Enter the new value for environment (dev, staging OR prod): "  environment && \
	sed -i 's/SPACE := dev/SPACE := '"$$environment"'/g' Makefile

setup: set_enviroment set_terraform_type
	@echo ""
	@echo ""
	@echo "run make init, make plan and make apply to privisioner infrastructure."
	@echo "any double run make help."
#===============================================================================
# UTILS
#===============================================================================
tf_clean: # remove unecessary .terraform folders and files
	@echo remove all .terraform folders...
	@find ./* -type d -name ".terraform" -exec rm -rf {} +
	@echo successfully removed all .terraform folders

help:
	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)
