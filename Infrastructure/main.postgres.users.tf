resource "google_sql_user" "iam_service_account" {
  name     = replace(google_service_account.sa.email, ".gserviceaccount.com", "")
  type     = "CLOUD_IAM_SERVICE_ACCOUNT"
  instance = google_sql_database_instance.postgres.name
}