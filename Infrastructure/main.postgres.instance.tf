resource "google_sql_database_instance" "postgres" {
  name                = "cloudrun-demo"
  region              = "europe-west4"
  database_version    = "POSTGRES_13"
  deletion_protection = true

  settings {
    tier            = "db-f1-micro"
    disk_type       = "PD_SSD"
    disk_autoresize = true

    activation_policy = "ALWAYS"
    availability_type = "ZONAL"

    database_flags {
      name  = "cloudsql.iam_authentication"
      value = "on"
    }
    ip_configuration {
      ipv4_enabled = true
      require_ssl  = true
    }
    maintenance_window {
      day          = 6
      hour         = 1
      update_track = "canary"
    }
    backup_configuration {
      enabled                        = true
      start_time                     = "02:00"
      point_in_time_recovery_enabled = true

      backup_retention_settings {
        retained_backups = 7
      }
    }
    insights_config {
      record_client_address   = true
      query_insights_enabled  = true
      record_application_tags = true
    }
  }
}