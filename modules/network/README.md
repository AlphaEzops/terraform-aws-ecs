<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 5.0 |

## Resources

| Name | Type |
|------|------|
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azs"></a> [azs](#input\_azs) | The availability zones for the VPC | `number` | `2` | no |
| <a name="input_commom_tags"></a> [commom\_tags](#input\_commom\_tags) | The common tags for all resources | `map(string)` | `{}` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment for all resources | `string` | `"dev"` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | The prefix for all resources | `string` | `"test"` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | The CIDR block for the VPC | `string` | `"10.0.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azs"></a> [azs](#output\_azs) | The availability zones for the VPC |
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | The private subnets for the VPC |
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | The public subnets for the VPC |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | The CIDR block of the VPC |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
| <a name="output_vpc_name"></a> [vpc\_name](#output\_vpc\_name) | The name of the VPC |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
