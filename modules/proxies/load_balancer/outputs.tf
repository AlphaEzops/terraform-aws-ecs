#===============================================================================
# HTTP
#===============================================================================
output "alb_arn" {
  description = "ARN of the Application Load Balancer"
  value       = aws_lb.this[0].arn
}


output "alb_name" {
  description = "Name of the Application Load Balancer"
  value = aws_lb.this[0].name
}

output "dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.this[0].dns_name
  
}
# output "http_listener_arn" {
#   description = "ARN of the listener"
#   value       = aws_lb_listener.http.arn
# }

#===============================================================================
# HTTPS
#===============================================================================
# output "https_target_group_arn" {
#   description = "ARN of the target group"
#   value       = aws_lb_target_group.https.arn
# }

# output "https_listener_arn" {
#   description = "ARN of the listener"
#   value       = aws_lb_listener.https.arn
# }
