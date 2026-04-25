module "vpc" {
  source       = "./modules/vpc"
  project_name = var.project_name
}

module "secrets" {
  source       = "./modules/secrets"
  project_name = var.project_name
}

module "iam" {
  source       = "./modules/iam"
  project_name = var.project_name
  secret_arn   = module.secrets.secret_arn
}

module "alb" {
  source          = "./modules/alb"
  project_name    = var.project_name
  vpc_id          = module.vpc.vpc_id
  public_subnets  = module.vpc.public_subnets
}

module "ecs" {
  source              = "./modules/ecs"
  project_name        = var.project_name
  vpc_id              = module.vpc.vpc_id
  private_subnets     = module.vpc.private_subnets
  execution_role_arn  = module.iam.execution_role_arn
  target_group_arn    = module.alb.target_group_arn
  alb_security_group  = module.alb.alb_sg_id
  container_image     = var.container_image
  secret_arn          = module.secrets.secret_arn
}

module "codepipeline" {
  source            = "./modules/codepipeline"
  project_name      = var.project_name
  ecs_cluster_name  = module.ecs.cluster_name
  ecs_service_name  = module.ecs.service_name
}