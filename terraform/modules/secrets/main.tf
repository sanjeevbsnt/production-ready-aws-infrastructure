resource "aws_secretsmanager_secret" "app_secret" {
  name = "${var.project_name}-secret"

  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "app_secret_value" {
  secret_id = aws_secretsmanager_secret.app_secret.id

  secret_string = jsonencode({
    username = var.db_username
    password = var.db_password
  })
}