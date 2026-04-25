terraform {
  backend "s3" {
    bucket         = "terraform-state-prod-bucket"
    key            = "production-ready/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}