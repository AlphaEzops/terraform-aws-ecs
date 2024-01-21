variable "create" {
  description = "Whether to create Github repository webhook for Atlantis"
  type        = bool
  default     = true
}

variable "repositories" {
  description = "List of names of repositories which belong to the owner specified in `github_owner`"
  type        = list(string)
  default     = []
}

variable "webhook_url" {
  description = "Webhook URL"
  type        = string
  default     = ""
}

variable "webhook_secret" {
  description = "Webhook secret"
  type        = string
  default     = ""
}

variable "events" {
  description = "List of events which trigger the webhook"
  type        = list(string)
  default = [
    "issue_comment",
    "pull_request",
    "pull_request_review",
    "pull_request_review_comment",
  ]
}
