resource "yandex_iam_service_account" "k8s_service_account" {
  name = "k8s-service-account"
}

resource "yandex_iam_service_account" "k8s_node_service_account" {
  name = "k8s-node-service-account"
}

resource "yandex_resourcemanager_cloud_iam_binding" "service_account_k8s" {
  cloud_id = var.cloud_id

  role = "editor"
  members = [
    "serviceAccount:${yandex_iam_service_account.k8s_service_account.id}",
    "serviceAccount:${yandex_iam_service_account.k8s_node_service_account.id}",
  ]
}

resource "yandex_resourcemanager_cloud_iam_binding" "service_account_k8s_public_admin" {
  cloud_id = var.cloud_id

  role = "vpc.publicAdmin"
  members = [
    "serviceAccount:${yandex_iam_service_account.k8s_service_account.id}",
    "serviceAccount:${yandex_iam_service_account.k8s_node_service_account.id}"
  ]
}
