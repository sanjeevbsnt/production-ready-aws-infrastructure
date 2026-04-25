resource "aws_secretsmanager_secret" "this" {
  name = "${var.project_name}-secret"
}

output "secret_arn" {
  value = aws_secretsmanager_secret.this.arn
}