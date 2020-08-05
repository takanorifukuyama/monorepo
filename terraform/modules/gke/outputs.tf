output "cluster_name" {
  value = module.gke.name
}

output "cluster_endpoint" {
  value = module.gke.endpoint
}

output "cluster_username" {
  value = module.gke.master_auth.0.username
}

output "cluster_password" {
  value = module.gke.master_auth.0.password
}

output "cluster_client_certificate" {
  value = module.gke.master_auth.0.client_certificate
}

output "cluster_client_key" {
  value = module.gke.master_auth.0.client_key
}

output "cluster_client_ca_certificate" {
  value = module.gke.master_auth.0.client_ca_certificate
}
