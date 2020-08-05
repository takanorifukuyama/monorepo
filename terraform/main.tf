provider "google" {
  region = var.region
  project = var.project_name
}

module "network" {
  source = "./modules/network"
  region = var.region
}

module "service_accounts" {
  source = "./modules/service_account"
  #  halyard_service_accout = module.service_account.halyard_service_accout
  #  spin_gcs_service_accout = module.service_account.spin_gcs_service_accout
}

module "gke" {
  source = "./modules/gke"
  project_name = var.project_name
  region = var.region
  zones = var.cluster_zones
  network_name = module.network.network_name
  subnetwork_name = module.network.subnetwork_name
  service_secondary_ip_range_name = module.network.service_secondary_ip_range_name
  pod_secondary_ip_range_name = module.network.pod_secondary_ip_range_name
  node_pools_name = var.node_pools_name
  node_preemptible = var.node_preemptible
  machine_type = var.machine_type
  node_min_count = var.node_min_count
  node_max_count = var.node_max_count
  disk_size_gb = var.disk_size_gb
}

module "bastion" {
  source = "./modules/bastion"
  project_name = var.project_name
  region = var.region
  bastion_zone = var.bastion_zone
  network_name = module.network.network_name
  network_self_link = module.network.network_self_link
  subnetwork_self_link = module.network.subnetwork_self_link
  members = var.bastion_members
  cluster_name = module.gke.cluster_name
}

#module "halyard_vm" {
#  source = "./modules/halyard_vm"terraform 0.12checklist
#  halyard_service_accout = module.service_account.halyard_service_accout
#  spin_gcs_service_accout = module.service_account.spin_gcs_service_accout
#}

data "google_client_config" "default" {
}

provider "kubernetes" {
  load_config_file = false
  host                   = module.gke.cluster_endpoint
  token = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.cluster_ca_certificate)
}

module "kubernetes" {
  source = "./modules/kubernetes"
}
