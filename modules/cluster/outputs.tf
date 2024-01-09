output "cluster_name" {
  description = "The name of the cluster"
  value = aws_ecs_cluster.cluster.name
}

output "cluster_id" {
  description = "The ID of the cluster"
  value = aws_ecs_cluster.cluster.id
}