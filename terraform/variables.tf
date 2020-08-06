variable "project_name" {}
variable "region" {}
variable "cluster_zones" {
  type = list(string)
}
variable "node_pools_name" {}
variable "node_preemptible" {}
variable "machine_type" {}
variable "node_min_count" {}
variable "node_max_count" {}
variable "disk_size_gb" {}
variable "bastion_zone" {}
variable "bastion_members" {
  type = list(string)
}

