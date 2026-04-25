resource "aws_s3_bucket" "artifacts" {
  bucket = "${var.project_name}-artifacts"
}

resource "aws_codepipeline" "this" {
  name     = "${var.project_name}-pipeline"
  role_arn = aws_iam_role.pipeline.arn

  artifact_store {
    location = aws_s3_bucket.artifacts.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "GitHub"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["src"]

      configuration = {
        Repo   = "repo"
        Branch = "main"
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "ECSDeploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ECS"
      input_artifacts = ["src"]
      version         = "1"

      configuration = {
        ClusterName = var.cluster
        ServiceName = var.service
      }
    }
  }
}