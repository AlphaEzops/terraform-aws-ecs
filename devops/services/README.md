<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |
| <a name="requirement_github"></a> [github](#requirement\_github) | >= 5.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_atlantis"></a> [atlantis](#module\_atlantis) | ./atlantis | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_ssm_parameter.github_owner](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |
| [aws_ssm_parameter.github_token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_name"></a> [alb\_name](#input\_alb\_name) | Name of the ALB | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the ECS cluster | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment for resources | `string` | n/a | yes |
| <a name="input_existent_hostzone_name"></a> [existent\_hostzone\_name](#input\_existent\_hostzone\_name) | value of existent hostzone name | `string` | `null` | no |
| <a name="input_hostzone_name"></a> [hostzone\_name](#input\_hostzone\_name) | value of hostzone name | `string` | `null` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | Owner of the resources | `string` | `"DevOps Team"` | no |
| <a name="input_project"></a> [project](#input\_project) | The project name | `string` | `"test"` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Name of the VPC | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
