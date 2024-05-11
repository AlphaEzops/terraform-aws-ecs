<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.1 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bastion"></a> [bastion](#module\_bastion) | ../../modules/proxies/bastion | n/a |
| <a name="module_cluster"></a> [cluster](#module\_cluster) | ../../modules/cluster | n/a |
| <a name="module_domain_name_server"></a> [domain\_name\_server](#module\_domain\_name\_server) | ../../modules/domain_name_server | n/a |
| <a name="module_firewall"></a> [firewall](#module\_firewall) | ../../modules/firewall | n/a |
| <a name="module_load_balancer"></a> [load\_balancer](#module\_load\_balancer) | ../../modules/proxies/load_balancer | n/a |
| <a name="module_network"></a> [network](#module\_network) | ../../modules/network | n/a |
| <a name="module_scaling"></a> [scaling](#module\_scaling) | ../../modules/scaling | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azs"></a> [azs](#input\_azs) | The availability zones for the VPC | `number` | `2` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment for all resources | `string` | `"dev"` | no |
| <a name="input_existent_acm_domain_name"></a> [existent\_acm\_domain\_name](#input\_existent\_acm\_domain\_name) | The name of the existent certificate | `string` | n/a | yes |
| <a name="input_existent_hostzone_name"></a> [existent\_hostzone\_name](#input\_existent\_hostzone\_name) | The name of the existent hostzone | `string` | n/a | yes |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | The prefix for all resources | `string` | `"test"` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | Owner of the resources | `string` | `"DevOps Team"` | no |
| <a name="input_project"></a> [project](#input\_project) | The project name | `string` | `"test"` | no |
| <a name="input_public_key"></a> [public\_key](#input\_public\_key) | The public key to install on the instance. | `string` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | The CIDR block for the VPC | `string` | `"10.0.0.0/16"` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
