variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-southeast-2"
}

variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
  default     = "production-ready"
}

variable "container_image" {
  description = "ECR image URL for ECS task"
  type        = string
}