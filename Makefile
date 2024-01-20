TF_DIR := ./devops
SPACE := cluster #cluster or services
ENVIRONMENT := ../../dev
PLAN_OUTPUT := plan.out

init: ## Initialize terraform
	cd $(TF_DIR)/$(SPACE) && terraform init

plan: ## Create a terraform plan
	cd $(TF_DIR)/$(SPACE) && terraform plan -out=$(PLAN_OUTPUT) -var-file=$(ENVIRONMENT).tfvars -compact-warnings

show: ## Show the terraform plan
	cd $(TF_DIR)/$(SPACE) && terraform show -json $(PLAN_OUTPUT) >> $(PLAN_OUTPUT).json

apply: ## Apply the terraform plan
	cd $(TF_DIR)/$(SPACE) && terraform apply $(PLAN_OUTPUT) 

destroy: ## Destroy the terraform plan
	cd $(TF_DIR)/$(SPACE) && terraform destroy -var-file=$(ENVIRONMENT).tfvars

help:
	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)
