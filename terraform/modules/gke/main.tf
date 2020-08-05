module "gke" {
  source = "terraform-google-modules/kubernetes-engine/google//modules/beta-private-cluster"
  version = "9.3.0"
  project_id = var.project_name
  name = "blue-${terraform.workspace}"
  region = var.region
  zones = var.zones
  network = var.network_name
  subnetwork = var.subnetwork_name
  ip_range_pods = var.pod_secondary_ip_range_name
  ip_range_services = var.service_secondary_ip_range_name
  http_load_balancing = true
  horizontal_pod_autoscaling = true
  network_policy = true
  enable_private_endpoint = true
  enable_private_nodes = true
  master_ipv4_cidr_block = "10.0.0.0/28"
  istio = true
  dns_cache = false
  remove_default_node_pool = true
  grant_registry_access = true
  master_authorized_networks = [
    {
      cidr_block = "10.0.0.0/8"
      display_name = "GCP"
    }
  ]

  node_pools = [
    {
      name = var.node_pools_name
      machine_type = var.machine_type
      min_count = var.node_min_count
      max_count = var.node_max_count
      local_ssd_count = 0
      disk_size_gb = var.disk_size_gb
      disk_type = "pd-standard"
      image_type = "COS"
      auto_repair = true
      auto_upgrade = true
      preemptible = var.node_preemptible
    },
  ]

  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}

module "kubernetes" {
  source = "./kubernetes"
}
