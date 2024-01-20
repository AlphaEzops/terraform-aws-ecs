output "autoscaling_group_arn" {
  description = "The ARN of the autoscaling group"
  value       = aws_autoscaling_group.this.arn
}
