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
| [aws_cloudfront_distribution.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudfront_certificate_arn"></a> [cloudfront\_certificate\_arn](#input\_cloudfront\_certificate\_arn) | ARN for CloudFront certificate | `string` | n/a | yes |
| <a name="input_custom_origin_host_header"></a> [custom\_origin\_host\_header](#input\_custom\_origin\_host\_header) | Custom header for the origin host | `string` | n/a | yes |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Domain name for CloudFront distribution | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment for resources | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace for resources | `string` | n/a | yes |
| <a name="input_origin_id"></a> [origin\_id](#input\_origin\_id) | Origin ID for CloudFront distribution | `string` | n/a | yes |
| <a name="input_target_origin_id"></a> [target\_origin\_id](#input\_target\_origin\_id) | Target origin ID for CloudFront distribution | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
