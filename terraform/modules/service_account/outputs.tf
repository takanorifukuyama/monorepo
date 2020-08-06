output "halyard_service_accout" {
  value = google_service_account.halyard.account_id
}

output "spin_gcs_service_accout" {
  value = google_service_account.spin-gcs.account_id
}
