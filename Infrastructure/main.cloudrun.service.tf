resource "google_cloud_run_service" "demo" {
  name     = "cloudrun-demo"
  location = "europe-west4"

  template {
    spec {
      service_account_name  = google_service_account.sa.email
      container_concurrency = 100

      containers {
        image = "eu.gcr.io/dev-dinero-cm/web:test"
        ports {
          container_port = 3000
        }
        resources {
          limits = {
            cpu    = "1000m"
            memory = "1024Mi"
          }
        }
        env {
          name = "Database__Name"
          value = "demodatabase"
        }
        env {
          name = "Database__Hostname"
          value = "/cloudsql/${google_sql_database_instance.postgres.connection_name}"
        }
        env {
          name = "Database__Username"
          value = replace(google_service_account.sa.email, ".gserviceaccount.com", "")
        }
        env {
          name = "Database__Password"
          value = "EMPTY-PASSWORD"
        }
      }
    }

    metadata {
      annotations = {
        "autoscaling.knative.dev/minScale" = 0
        "autoscaling.knative.dev/maxScale" = 1
        "run.googleapis.com/cloudsql-instances" = google_sql_database_instance.postgres.connection_name
      }
    }
  }

  autogenerate_revision_name = true
}