resource "google_compute_network" "network" {
  name = "blue-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name = "blue-subnet"
  ip_cidr_range = "10.126.0.0/20"
  network = google_compute_network.network.self_link
  region = var.region
  private_ip_google_access = true
  secondary_ip_range = [
    {
      range_name = "gke-pods"
      ip_cidr_range = "172.16.0.0/20"
    },
    {
      range_name = "gke-services"
      ip_cidr_range = "172.17.0.0/20"
    }
  ]
}

resource "google_compute_router" "router" {
  name = "blue-router"
  region = google_compute_subnetwork.subnet.region
  network = google_compute_network.network.self_link

  bgp {
    asn = 64514
  }
}

resource "google_compute_address" "nat_address" {
  name = "blue-nat-ip"
  region = var.region
}

resource "google_compute_router_nat" "nat" {
  name = "blue-router-nat"
  router = google_compute_router.router.name
  region = google_compute_router.router.region
  nat_ip_allocate_option = "MANUAL_ONLY"
  nat_ips = [
    google_compute_address.nat_address.self_link
  ]
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

resource "google_compute_global_address" "blue-ingress-ip" {
  name = "blue-ingress-ip"
}
