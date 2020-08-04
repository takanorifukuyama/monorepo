output "network_name" {
  value = google_compute_network.network.name
}

output "subnetwork_name" {
  value = google_compute_subnetwork.subnet.name
}

output "network_self_link" {
  value = google_compute_network.network.self_link
}

output "subnetwork_self_link" {
  value = google_compute_subnetwork.subnet.self_link
}

output "pod_secondary_ip_range_name" {
  value = google_compute_subnetwork.subnet.secondary_ip_range[0].range_name
}

output "service_secondary_ip_range_name" {
  value = google_compute_subnetwork.subnet.secondary_ip_range[1].range_name
}
