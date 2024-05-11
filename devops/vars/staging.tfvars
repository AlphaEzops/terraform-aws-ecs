#----------------------------------
# GENERAL
#----------------------------------
name_prefix = "demo"
environment = "staging"
owner       = "DevOps Team"
project     = "unknown"
#----------------------------------
# NETWORK
#----------------------------------
vpc_name = "demo-staging"
vpc_cidr = "10.0.0.0/16"
azs      = 3
#----------------------------------
# SCALING
#----------------------------------
public_key = "your_public_key"
#----------------------------------
# CLUSTER
#----------------------------------
#----------------------------------
# CONTENT DELIVERY NETWORK
#----------------------------------
existent_hostzone_name   = "staging.ezops.com.br"
existent_acm_domain_name = "*.staging.ezops.com.br"
#----------------------------------
# DOMAIN NAME SERVER
#----------------------------------
#----------------------------------
# FIREWALL
#----------------------------------
#----------------------------------
# PROXY
#----------------------------------
#----------------------------------
# SERVICE
#----------------------------------
cluster_name      = "demo-staging"
alb_name          = "demo-staging"
target_group_name = "demo-staging-https-tg"
