variable "project_name" {}
variable "region" {}
variable "bastion_zone" {}
variable "network_name" {}
variable "network_self_link" {}
variable "subnetwork_self_link" {}
variable "members" {
  type = list(string)
}
variable "cluster_name" {}
