resource "google_service_account" "sa" {
  account_id   = "cloudrun-demo"
}

resource "google_project_iam_binding" "sa-role" {
  for_each = toset([
    "roles/run.invoker",
    "roles/cloudsql.client",
    "roles/cloudsql.instanceUser",
    "roles/iam.serviceAccountUser"
  ])

  role    = each.key
  members = ["serviceAccount:${google_service_account.sa.email}", ]
}