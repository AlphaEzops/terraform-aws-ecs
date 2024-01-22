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

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_ecs_service.service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_role.ecs_task_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.ecs_task_iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.ecs_task_execution_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lb_listener_rule.https_listener_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws_lb_target_group.target_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_route53_record.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_alb.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/alb) | data source |
| [aws_ecs_cluster.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ecs_cluster) | data source |
| [aws_iam_policy_document.task_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_lb_listener.https_listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/lb_listener) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_route53_zone.zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
| [aws_vpc.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_listener_port"></a> [alb\_listener\_port](#input\_alb\_listener\_port) | Port of the ALB listener | `number` | `443` | no |
| <a name="input_alb_name"></a> [alb\_name](#input\_alb\_name) | Name of the ALB | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the ECS cluster | `string` | n/a | yes |
| <a name="input_condition"></a> [condition](#input\_condition) | Condition of the ALB listener rule | <pre>list(object({<br>    path_pattern = list(string)<br>    host_header  = list(string)<br>  }))</pre> | <pre>[<br>  {<br>    "host_header": [<br>      "atlantis.dev.tmaior.com.br"<br>    ],<br>    "path_pattern": [<br>      "/"<br>    ]<br>  }<br>]</pre> | no |
| <a name="input_container_port"></a> [container\_port](#input\_container\_port) | Container port for ECS task | `number` | n/a | yes |
| <a name="input_cpu_units"></a> [cpu\_units](#input\_cpu\_units) | CPU units for ECS task | `number` | `256` | no |
| <a name="input_ecs_task_deployment_maximum_percent"></a> [ecs\_task\_deployment\_maximum\_percent](#input\_ecs\_task\_deployment\_maximum\_percent) | Maximum percent during ECS task deployment | `number` | `200` | no |
| <a name="input_ecs_task_deployment_minimum_healthy_percent"></a> [ecs\_task\_deployment\_minimum\_healthy\_percent](#input\_ecs\_task\_deployment\_minimum\_healthy\_percent) | Minimum healthy percent during ECS task deployment | `number` | `50` | no |
| <a name="input_ecs_task_desired_count"></a> [ecs\_task\_desired\_count](#input\_ecs\_task\_desired\_count) | Desired count of ECS tasks | `number` | `1` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment for resources | `string` | n/a | yes |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | values for environment variables | `list(any)` | `[]` | no |
| <a name="input_existent_hostzone_name"></a> [existent\_hostzone\_name](#input\_existent\_hostzone\_name) | value of existent hostzone name | `string` | `null` | no |
| <a name="input_hash"></a> [hash](#input\_hash) | Docker image hash | `string` | n/a | yes |
| <a name="input_hostzone_name"></a> [hostzone\_name](#input\_hostzone\_name) | value of hostzone name | `string` | `null` | no |
| <a name="input_image"></a> [image](#input\_image) | Docker image | `string` | n/a | yes |
| <a name="input_memory"></a> [memory](#input\_memory) | Memory for ECS task | `number` | `512` | no |
| <a name="input_priority"></a> [priority](#input\_priority) | Priority of the ALB listener rule | `number` | `100` | no |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | values for secrets | <pre>list(object({<br>    name      = string<br>    valueFrom = string<br>  }))</pre> | `[]` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Name of the ECS service | `string` | n/a | yes |
| <a name="input_target_group"></a> [target\_group](#input\_target\_group) | values for target group | <pre>object({<br>    port        = number<br>    protocol    = string<br>    target_type = string<br>    health_check = object({<br>      path                = string<br>      port                = string<br>      protocol            = string<br>      healthy_threshold   = number<br>      unhealthy_threshold = number<br>      timeout             = number<br>      interval            = number<br>    })<br>  })</pre> | <pre>{<br>  "health_check": {<br>    "healthy_threshold": 2,<br>    "interval": 20,<br>    "path": "/",<br>    "port": "443",<br>    "protocol": "HTTPS",<br>    "timeout": 3,<br>    "unhealthy_threshold": 2<br>  },<br>  "port": 443,<br>  "protocol": "HTTPS",<br>  "target_type": "ip"<br>}</pre> | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Name of the VPC | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
