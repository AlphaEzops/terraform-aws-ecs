TF_DIR := ./devops
SPACE := cluster
ENVIRONMENT := dev
PLAN_OUTPUT := plan.out
TERRAFORM_OR_OPENTOFU := tofu

#===============================================================================
# INFRA AS CODE
#===============================================================================
init: ## Initialize terraform
	@cd $(TF_DIR)/$(SPACE) && $(TERRAFORM_OR_OPENTOFU) init

plan: ## Create a terraform plan
	@cd $(TF_DIR)/$(SPACE) && $(TERRAFORM_OR_OPENTOFU) plan -out=$(PLAN_OUTPUT) -var-file=../vars/$(ENVIRONMENT).tfvars

show: ## Show the terraform plan
	@cd $(TF_DIR)/$(SPACE) && $(TERRAFORM_OR_OPENTOFU) show -json $(PLAN_OUTPUT) >> $(PLAN_OUTPUT).json

apply: ## Apply the terraform plan
	@cd $(TF_DIR)/$(SPACE) && $(TERRAFORM_OR_OPENTOFU) apply $(PLAN_OUTPUT) 

destroy: ## Destroy the terraform plan
	@cd $(TF_DIR)/$(SPACE) && $(TERRAFORM_OR_OPENTOFU) destroy -var-file=../vars/$(ENVIRONMENT).tfvars

#===============================================================================
# SET ENVIRONMENT
#===============================================================================
get_current_info:
	@echo "IaC type: $(TERRAFORM_OR_OPENTOFU)" 
	@echo "IaC state: $(SPACE)"
	@echo "Environment: $(ENVIRONMENT)"

set_tf_state: ## SET the value of SPACE variable
	@read -p "Enter the new value for SPACE (cluster or services): " space && \
	sed -i 's/SPACE := cluster/SPACE := '"$$space"'/g' Makefile

set_terraform_type: ## SET the value of Terraform type
	@read -p "Enter the new value for  (terraform or tofu): " type && \
	sed -i 's/TERRAFORM_OR_OPENTOFU := tofu/TERRAFORM_OR_OPENTOFU := '"$$type"'/g' Makefile

set_enviroment: ## SET the value of ENVIRONMENT variable
	@read -p "Enter the new value for environment (dev, staging OR prod): "  environment && \
	sed -i 's/SPACE := cluster/SPACE := '"$$environment"'/g' Makefile

setup: set_enviroment set_terraform_type set_tf_state
	@echo ""
	@echo ""
	@echo "run make init, make plan and make apply to privisioner infrastructure."
	@echo "any double run make help."
#===============================================================================
# UTILS
#===============================================================================
remove_tf_vars: # remove unecessary .terraform folders and files
	@echo remove all .terraform folders...
	@find devops modules -type f \( -name ".terraform" -o -name ".terraform.lock.hcl" \) -exec rm -rf {} \;

help:
	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)
