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
