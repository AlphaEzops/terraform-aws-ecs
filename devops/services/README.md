<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_service"></a> [service](#module\_service) | ../../modules/service | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_ecs_cluster.ecs_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ecs_cluster) | data source |
| [aws_lb_target_group.https_target_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/lb_target_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the ECS cluster | `string` | n/a | yes |
| <a name="input_container_port"></a> [container\_port](#input\_container\_port) | Container port for ECS task | `number` | `80` | no |
| <a name="input_cpu_units"></a> [cpu\_units](#input\_cpu\_units) | CPU units for ECS task | `number` | `256` | no |
| <a name="input_ecs_task_deployment_maximum_percent"></a> [ecs\_task\_deployment\_maximum\_percent](#input\_ecs\_task\_deployment\_maximum\_percent) | Maximum percent during ECS task deployment | `number` | `200` | no |
| <a name="input_ecs_task_deployment_minimum_healthy_percent"></a> [ecs\_task\_deployment\_minimum\_healthy\_percent](#input\_ecs\_task\_deployment\_minimum\_healthy\_percent) | Minimum healthy percent during ECS task deployment | `number` | `50` | no |
| <a name="input_ecs_task_desired_count"></a> [ecs\_task\_desired\_count](#input\_ecs\_task\_desired\_count) | Desired count of ECS tasks | `number` | `1` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment for resources | `string` | n/a | yes |
| <a name="input_hash"></a> [hash](#input\_hash) | Docker image hash | `string` | `"latest"` | no |
| <a name="input_image"></a> [image](#input\_image) | Docker image | `string` | `"nginx"` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | Memory for ECS task | `number` | `512` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Name of the ECS service | `string` | `"nginx"` | no |
| <a name="input_target_group_name"></a> [target\_group\_name](#input\_target\_group\_name) | ARN of the target group | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
