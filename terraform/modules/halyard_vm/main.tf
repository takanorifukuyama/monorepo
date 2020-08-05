data "google_compute_image" "ubuntu_image" {
  name    = "ubuntu-1404-trusty-v20190410"
  project = "ubuntu-os-cloud"
}

resource "google_compute_instance" "halyard" {
  depends_on   = ["google_container_node_pool.spinnaker"]
  name         = "${var.halyard_vm_name}"
  machine_type = "g1-small"

  boot_disk {
    initialize_params {
      image = "${data.google_compute_image.ubuntu_image.self_link}"
    }
  }

  network_interface {
    network       = "default"
    access_config = {}
  }

  service_account {
    email  = "${google_service_account.halyard.email}"
    scopes = ["cloud-platform"]
  }

  metadata {
    "block-project-ssh-keys" = "true"
    "sshKeys"                = "${var.gcp_account_name}:${file("ssh/halyard_vm_rsa.pub")}"
  }

  provisioner "remote-exec" {
    inline = [
      "KUBECTL_LATEST=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)",
      "curl -LO https://storage.googleapis.com/kubernetes-release/release/$KUBECTL_LATEST/bin/linux/amd64/kubectl",
      "chmod +x kubectl",
      "sudo mv kubectl /usr/local/bin/kubectl",
      "curl -O https://raw.githubusercontent.com/spinnaker/halyard/master/install/debian/InstallHalyard.sh",
      "sudo bash InstallHalyard.sh --user ${var.gcp_account_name} -y",
      ". ~/.bashrc",
      "gcloud config set container/use_client_certificate true",
      "gcloud container clusters get-credentials ${var.gke_cluster_name} --zone=${var.gcp_zone}",
      "GCS_SA_DEST=~/.gcp/gcp.json",
      "mkdir -p $(dirname $GCS_SA_DEST)",
      "gcloud iam service-accounts keys create $GCS_SA_DEST --iam-account ${google_service_account.spin-gcs.email}",
      "hal config version edit --version $(hal version latest -q)",
      "hal config storage gcs edit --project $(gcloud info --format='value(config.project)') --json-path $GCS_SA_DEST",
      "hal config storage edit --type gcs",
      "hal config provider docker-registry enable",
      "hal config provider docker-registry account add my-gcr-account --address gcr.io --password-file $GCS_SA_DEST --username _json_key",
      "CONTEXT=$(kubectl config current-context)",
      "TOKEN=$(kubectl get secret --context $CONTEXT ${kubernetes_service_account.spinnaker-sa.default_secret_name} -n spinnaker -o jsonpath='{.data.token}' | base64 --decode)",
      "kubectl config set-credentials $${CONTEXT}-token-user --token $TOKEN",
      "kubectl config set-context $CONTEXT --user $${CONTEXT}-token-user",
      "hal config provider kubernetes enable",
      "hal config provider kubernetes account add my-k8s-account --docker-registries my-gcr-account --provider-version v2 --context $CONTEXT",
      "hal config deploy edit --account-name my-k8s-account --type distributed",
      "hal deploy apply",
    ]
    connection {
      type        = "ssh"
      user        = "${var.gcp_account_name}"
      private_key = "${file("ssh/halyard_vm_rsa")}"
      timeout     = "5m"
    }
  }
}
