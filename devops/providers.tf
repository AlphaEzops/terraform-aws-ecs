provider "aws" {
  default_tags {
    tags = {
      Project     = var.project
      Owner       = var.owner
      Environment = var.environment
      terraform   = "true"
    }
  }
}

# provider "github" {
#   token = data.aws_ssm_parameter.github_token.value
#   owner = data.aws_ssm_parameter.github_owner.value
# }
