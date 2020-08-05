resource "kubernetes_cluster_role_binding" "client-admin-binding" {
  metadata {
    name = "client-admin"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    kind      = "User"
    name      = "client"
  }
}

resource "kubernetes_namespace" "spinnaker" {
  metadata {
    annotations {
      name = "spinnaker"
    }

    name = "spinnaker"
  }
}

resource "kubernetes_service_account" "spinnaker-sa" {
  depends_on = ["kubernetes_namespace.spinnaker"]
  metadata {
    name      = "spinnaker-service-account"
    namespace = "spinnaker"
  }
}

resource "kubernetes_cluster_role_binding" "spinnaker-binding-admin" {
  depends_on = ["kubernetes_namespace.spinnaker"]
  metadata {
    name = "spinnaker-admin"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    kind      = "ServiceAccount"
    name      = "spinnaker-service-account"
    namespace = "spinnaker"
  }
}

resource "kubernetes_cluster_role" "spinnaker-role" {
  metadata {
    name = "spinnaker-role"
  }

  rule {
    api_groups = [""]
    resources  = ["namespaces", "configmaps", "events", "replicationcontrollers", "serviceaccounts", "pods/log"]
    verbs      = ["get", "list"]
  }

  rule {
    api_groups = [""]
    resources  = ["pods", "services", "secrets"]
    verbs      = ["create", "delete", "deletecollection", "get", "list", "patch", "update", "watch"]
  }

  rule {
    api_groups = ["autoscaling"]
    resources = ["horizontalpodautoscalers"]
    verbs     = ["list", "get"]
  }

  rule {
    api_groups = ["apps"]
    resources = ["controllerrevisions", "statefulsets"]
    verbs     = ["list"]
  }

  rule {
    api_groups = ["extensions", "apps"]
    resources = ["deployments", "replicasets", "ingresses"]
    verbs     = ["create", "delete", "deletecollection", "get", "list", "patch", "update", "watch"]
  }

  # These permissions are necessary for halyard to operate. We use this role also to deploy Spinnaker itself.
  rule {
    api_groups = [""]
    resources = ["services/proxy", "pods/portforward"]
    verbs     = ["create", "delete", "deletecollection", "get", "list", "patch", "update", "watch"]
  }
}

resource "kubernetes_cluster_role_binding" "spinnaker-role-bindings" {
  depends_on = ["kubernetes_namespace.spinnaker", "kubernetes_service_account.spinnaker-sa"]
  metadata {
    name = "spinnaker-role-binding"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "spinnaker-role"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "spinnaker-service-account"
    namespace = "spinnaker"
  }
}
