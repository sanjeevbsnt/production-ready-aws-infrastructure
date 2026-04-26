variable "project_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}

variable "alb_security_group" {
  type = string
}

variable "target_group_arn" {
  type = string
}

variable "execution_role_arn" {
  type = string
}

variable "container_image" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "listener_dependency" {
  description = "Listener dependency to avoid race condition"
}
