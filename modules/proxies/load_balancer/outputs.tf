output "http_target_group_arn" {
  description = "ARN of the target group"
  value       = aws_lb_target_group.http.arn
}

output "https_target_group_arn" {
  description = "ARN of the target group"
  value       = aws_lb_target_group.https.arn
}
