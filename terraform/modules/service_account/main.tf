resource "google_service_account" "halyard" {
  account_id   = "halyard-service-account"
  display_name = "halyard & Spinnaker service account"
}

resource "google_project_iam_member" "halyard-iam-keyadmin" {
  depends_on = ["google_service_account.halyard"]
  role       = "roles/iam.serviceAccountKeyAdmin"
  member     = "serviceAccount:${google_service_account.halyard.email}"
}

resource "google_project_iam_member" "halyard-iam-containeradmin" {
  depends_on = ["google_service_account.halyard"]
  role       = "roles/container.admin"
  member     = "serviceAccount:${google_service_account.halyard.email}"
}

resource "google_service_account" "spin-gcs" {
  account_id   = "spin-gcs-service-account"
  display_name = "halyard & Spinnaker cloud storage service account"
}

resource "google_project_iam_member" "SpinGCS-iam-storageadmin" {
  depends_on = ["google_service_account.spin-gcs"]
  role       = "roles/storage.admin"
  member     = "serviceAccount:${google_service_account.spin-gcs.email}"
}

resource "google_project_iam_member" "SpinGCS-iam-browser" {
  depends_on = ["google_service_account.spin-gcs"]
  role       = "roles/browser"
  member     = "serviceAccount:${google_service_account.spin-gcs.email}"
}
