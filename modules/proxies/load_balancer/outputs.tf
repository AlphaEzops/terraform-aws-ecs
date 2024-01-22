#===============================================================================
# HTTP
#===============================================================================
output "http_target_group_arn" {
  description = "ARN of the target group"
  value       = aws_lb_target_group.http.arn
}

output "http_listener_arn" {
  description = "ARN of the listener"
  value       = aws_lb_listener.http.arn
}
#===============================================================================
# HTTPS
#===============================================================================
# output "https_target_group_arn" {
#   description = "ARN of the target group"
#   value       = aws_lb_target_group.https.arn
# }

output "https_listener_arn" {
  description = "ARN of the listener"
  value       = aws_lb_listener.https.arn
}
