variable "project_name" {}
variable "region" {}
variable "zones" {
  type = list(string)
}
variable "network_name" {}
variable "subnetwork_name" {}
variable "pod_secondary_ip_range_name" {}
variable "service_secondary_ip_range_name" {}
variable "node_pools_name" {}
variable "node_preemptible" {}
variable "machine_type" {}
variable "node_min_count" {}
variable "node_max_count" {}
variable "disk_size_gb" {}

variable "halyard_service_accout" {}
variable "spin_gcs_service_accout" {}
