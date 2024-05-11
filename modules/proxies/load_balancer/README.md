<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_lb.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_logs"></a> [access\_logs](#input\_access\_logs) | value of access logs | `map(any)` | `null` | no |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | value of common tags | `map(string)` | `{}` | no |
| <a name="input_enable_deletion_protection"></a> [enable\_deletion\_protection](#input\_enable\_deletion\_protection) | value of deletion protection | `bool` | `false` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | value of enabled module | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment for all resources | `string` | `"dev"` | no |
| <a name="input_internal"></a> [internal](#input\_internal) | value of internal | `bool` | `false` | no |
| <a name="input_load_balancer_type"></a> [load\_balancer\_type](#input\_load\_balancer\_type) | value of load balancer type | `string` | `"application"` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | value of name | `string` | `"demo"` | no |
| <a name="input_security_groups_id"></a> [security\_groups\_id](#input\_security\_groups\_id) | value of security group id | `list(string)` | n/a | yes |
| <a name="input_subnets_id"></a> [subnets\_id](#input\_subnets\_id) | value of subnets id | `list(string)` | n/a | yes |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Create, update, and delete timeout configurations for the cluster | `map(string)` | <pre>{<br>  "create": "10m",<br>  "delete": "10m",<br>  "update": "10m"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_arn"></a> [alb\_arn](#output\_alb\_arn) | ARN of the Application Load Balancer |
| <a name="output_alb_name"></a> [alb\_name](#output\_alb\_name) | Name of the Application Load Balancer |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
