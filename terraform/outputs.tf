output "alb_dns_name" {
  description = "Public DNS of Application Load Balancer"
  value       = module.alb.alb_dns
}

output "ecs_cluster_name" {
  description = "ECS Cluster Name"
  value       = module.ecs.cluster_name
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}