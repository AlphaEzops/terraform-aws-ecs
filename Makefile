TF_DIR := ./devops
ENVIRONMENT := dev
PLAN_OUTPUT := plan.out
TF_BUCKET := alpha-team-ezops
TF_KEY := $(ENVIRONMENT)/terraform.tfstate

#===============================================================================
# INFRA AS CODE
#===============================================================================
init: ## Initialize terraform
	@cd $(TF_DIR) && terraform init \
		-backend-config="bucket=$(TF_BUCKET)" \
		-backend-config="key=$(TF_KEY)" \
		-backend-config="encrypt=true" -upgrade

plan: ## Create a terraform plan
	@cd $(TF_DIR) && terraform plan -out=$(PLAN_OUTPUT) -var-file=./vars/$(ENVIRONMENT).tfvars

show: ## Show the terraform plan
	@cd $(TF_DIR) && terraform show -json $(PLAN_OUTPUT) >> $(PLAN_OUTPUT).json

apply: ## Apply the terraform apply
	@cd $(TF_DIR) && terraform apply $(PLAN_OUTPUT)

apply_auto_aprove: ## Apply the terraform plan with auto approve
	@cd $(TF_DIR) && terraform apply $(PLAN_OUTPUT) -auto-approve -input=false

destroy: ## Destroy the terraform infra
	@cd $(TF_DIR) && terraform destroy -var-file=./vars/$(ENVIRONMENT).tfvars

#===============================================================================
# SET ENVIRONMENT
#===============================================================================
get_current_info: ## Get the current value of the ENVIRONMENT variable
	@echo "Environment: $(ENVIRONMENT)"

set_terraform_type: ## SET the value of Terraform type
	@read -p "Enter the new value for  (terraform or tofu): " type && \
	sed -i 's/TERRAFORM_OR_OPENTOFU := tofu/TERRAFORM_OR_OPENTOFU := '"$$type"'/g' Makefile

set_enviroment: ## SET the value of ENVIRONMENT variable
	@read -p "Enter the new value for environment (dev, staging OR prod): "  environment && \
	sed -i 's/SPACE := dev/SPACE := '"$$environment"'/g' Makefile

set_tf_bucket: ## SET the value of TF_BUCKET variable
	@read -p "Enter the new value of terraform bucket name: "  bucket_name && \
	sed -i 's/TF_BUCKET := test/TF_BUCKET := '"$$bucket_name"'/g' Makefile

setup: set_terraform_type set_tf_bucket
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
