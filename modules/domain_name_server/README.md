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
| [aws_acm_certificate.acm_certificate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate_validation.acm_certificate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation) | resource |
| [aws_route53_record.acm_record_certificate_validation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |
| [aws_acm_certificate.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/acm_certificate) | data source |
| [aws_route53_zone.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acm_domain_name"></a> [acm\_domain\_name](#input\_acm\_domain\_name) | value of acm domain name | `string` | `null` | no |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | value of common tags | `map(string)` | `{}` | no |
| <a name="input_existent_acm_domain_name"></a> [existent\_acm\_domain\_name](#input\_existent\_acm\_domain\_name) | value of existent acm domain name | `string` | `null` | no |
| <a name="input_existent_hostzone_name"></a> [existent\_hostzone\_name](#input\_existent\_hostzone\_name) | value of existent hostzone name | `string` | `null` | no |
| <a name="input_hostzone_name"></a> [hostzone\_name](#input\_hostzone\_name) | value of hostzone name | `string` | `null` | no |
| <a name="input_record_config"></a> [record\_config](#input\_record\_config) | dns route53 record config | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_certificate_arn"></a> [certificate\_arn](#output\_certificate\_arn) | The ARN of the ACM certificate |
| <a name="output_existent_certificate_arn"></a> [existent\_certificate\_arn](#output\_existent\_certificate\_arn) | The ARN of the existent ACM certificate |
| <a name="output_existent_hostzone_id"></a> [existent\_hostzone\_id](#output\_existent\_hostzone\_id) | The ID of the existent hostzone |
| <a name="output_existent_hostzone_name"></a> [existent\_hostzone\_name](#output\_existent\_hostzone\_name) | The name of the existent hostzone |
| <a name="output_hostzone_id"></a> [hostzone\_id](#output\_hostzone\_id) | The ID of the hostzone |
| <a name="output_hostzone_name"></a> [hostzone\_name](#output\_hostzone\_name) | The name of the hostzone |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
