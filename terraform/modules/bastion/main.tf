module "iap_bastion" {
  source = "terraform-google-modules/bastion-host/google"
  version = "2.5.0"
  project = var.project_name
  region = var.region
  zone = var.bastion_zone
  network = var.network_self_link
  subnet = var.subnetwork_self_link
  members = var.members
  service_account_roles_supplemental = [
    // $ gcloud container clusters list
    // ERROR: (gcloud.container.clusters.list) ResponseError: code=403, message=Required "container.clusters.list" permission(s) for "projects/xxxxxxxx".
    "roles/container.clusterAdmin",
    // $ kubectl get pod
    // Error from server (Forbidden): pods is forbidden: User "110358792293909044182" cannot list resource "pods" in API group "" in the namespace "default": Required "container.pods.list" permission.
    // $ kubectl create clusterrolebinding "cluster-admin-bastion" \
    // > --clusterrole=cluster-admin \
    // > --user="$(gcloud config get-value core/account)"
    // Error from server (Forbidden): clusterrolebindings.rbac.authorization.k8s.io is forbidden: User "109904733323051370338" cannot create resource "clusterrolebindings" in API group "rbac.authorization.k8s.io" at the cluster scope: requires one of ["container.clusterRoleBindings.create"] permission(s).
    // https://docs.fluxcd.io/en/1.17.1/tutorials/get-started.html#prerequisites
    "roles/container.admin"
  ]
  create_instance_from_template = false
}

resource "google_compute_firewall" "allow_access_from_bastion" {
  project = var.project_name
  name = "allow-bastion-ssh"
  network = var.network_self_link

  allow {
    protocol = "tcp"
    ports = [
      "22"]
  }

  # Allow SSH only from IAP Bastion
  source_service_accounts = [
    module.iap_bastion.service_account
  ]
}

resource "google_compute_autoscaler" "bastion" {
  name = "bastion-autoscaler"
  zone = "asia-northeast1-a"
  target = google_compute_instance_group_manager.bastion.id

  autoscaling_policy {
    max_replicas = 1
    min_replicas = 1
    cooldown_period = 60

    cpu_utilization {
      target = 0.9
    }
  }
}

resource "google_compute_instance_template" "bastion" {
  name = "bastion-instance-template"
  machine_type = "n1-standard-1"
  can_ip_forward = false

  disk {
    source_image = data.google_compute_image.centos_7.self_link
  }

  network_interface {
    network = var.network_self_link
    subnetwork = var.subnetwork_self_link
  }

  service_account {
    email = module.iap_bastion.service_account
    scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  scheduling {
    preemptible = true
    automatic_restart = false
  }

  metadata_startup_script = <<EOT
sudo yum install -y epel-release snapd kubectl git curl
echo "gcloud container clusters get-credentials ${var.cluster_name} --region asia-northeast1" | sudo tee -a /etc/profile
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap
sudo snap list
sudo snap install helm --classic
sudo snap install fluxctl --classic
helm repo add fluxcd https://charts.fluxcd.io
EOT
}

resource "google_compute_target_pool" "bastion" {
  name = "basion-target-pool"
}

resource "google_compute_instance_group_manager" "bastion" {
  name = "basion-igm"
  zone = "asia-northeast1-a"

  version {
    instance_template = google_compute_instance_template.bastion.id
  }

  target_pools = [
    google_compute_target_pool.bastion.id]
  base_instance_name = "bastion"
}

data "google_compute_image" "centos_7" {
  family = "centos-7"
  project = "gce-uefi-images"
}
