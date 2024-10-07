provider "kubernetes" {
  config_path = "~/.kube/config"
}


resource "kubernetes_service_account" "github_actions" {
  metadata {
    name      = "github-actions-sa"
    namespace = "default"
  }
}

resource "kubernetes_cluster_role" "github_actions_role" {
  metadata {
    name = "github-actions-role"
  }

  rule {
    api_groups = ["apps"]
    resources  = ["deployments"]
    verbs      = ["get", "list", "watch", "create", "update", "patch", "delete"]
  }

  rule {
    api_groups = [""]
    resources  = ["pods", "pods/log", "services"]
    verbs      = ["get", "list", "watch", "create", "update", "patch", "delete"]
  }
}

resource "kubernetes_cluster_role_binding" "github_actions_binding" {
  metadata {
    name = "github-actions-role-binding"
  }

  role_ref {
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.github_actions_role.metadata[0].name
    api_group = "rbac.authorization.k8s.io"
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.github_actions.metadata[0].name
    namespace = kubernetes_service_account.github_actions.metadata[0].namespace
  }
}
