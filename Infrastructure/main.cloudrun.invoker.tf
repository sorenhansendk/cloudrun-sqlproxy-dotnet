data "google_iam_policy" "noauth" {
  binding {
    role    = "roles/run.invoker"
    members = ["allUsers"]
  }
}

resource "google_cloud_run_service_iam_policy" "api-noauth" {
  location = google_cloud_run_service.demo.location
  project  = google_cloud_run_service.demo.project
  service  = google_cloud_run_service.demo.name

  policy_data = data.google_iam_policy.noauth.policy_data
}