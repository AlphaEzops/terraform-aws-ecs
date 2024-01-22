locals {
  aws_ecr_repository = { for key, value in var.aws_ecr_repository : key => value }
}

resource "aws_ecr_repository" "this" {
  for_each             = local.aws_ecr_repository
  name                 = each.value.name
  image_tag_mutability = each.value.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = each.value.scan_on_push
  }
}

resource "aws_ecr_lifecycle_policy" "this" {
  count      = length(aws_ecr_repository.this)
  repository = aws_ecr_repository.this[count.index].name

  policy = <<EOF
{
  "rules": [
    {
      "rulePriority": 1,
      "description": "Expire images older than 14 days",
      "selection": {
          "tagStatus": "untagged",
          "countType": "sinceImagePushed",
          "countUnit": "days",
          "countNumber": 14
      },
      "action": {
          "type": "expire"
      }
    }
  ]
}
EOF
}

data "aws_iam_policy_document" "this" {
  statement {
    sid = "AllowPushPull"

    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:DescribeRepositories",
      "ecr:GetRepositoryPolicy",
      "ecr:ListImages",
      "ecr:DeleteRepository",
      "ecr:BatchDeleteImage",
      "ecr:SetRepositoryPolicy",
      "ecr:DeleteRepositoryPolicy",
    ]

    resources = ["*"]
  }
}
resource "aws_ecr_repository_policy" "this" {
  count      = length(aws_ecr_repository.this)
  repository = aws_ecr_repository.this[count.index].name

  policy = data.aws_iam_policy_document.this.json
}
