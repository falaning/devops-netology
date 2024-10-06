resource "yandex_kubernetes_cluster" "my_cluster" {
  name                    = "my-cluster"
  network_id              = "enpu35ul8llj08gi2f6o"
  service_account_id      = yandex_iam_service_account.k8s_service_account.id
  node_service_account_id = yandex_iam_service_account.k8s_node_service_account.id

  master {
    public_ip = true
    regional {
      region = "ru-central1"

      location {
        zone = "ru-central1-a"
        subnet_id = yandex_vpc_subnet.my_subnet_a.id
      }
      location {
        zone = "ru-central1-b"
        subnet_id = yandex_vpc_subnet.my_subnet_b.id
      }
      location {
        zone = "ru-central1-d"
        subnet_id = yandex_vpc_subnet.my_subnet_d.id
      }
    }
  }
}

# Создание группы нод для Kubernetes кластера
resource "yandex_kubernetes_node_group" "my_node_group" {
  cluster_id = yandex_kubernetes_cluster.my_cluster.id

  name = "my-node-group"

  allocation_policy {
    location {
      zone = "ru-central1-a"
    }
    location {
      zone = "ru-central1-b"
    }
    location {
      zone = "ru-central1-d"
    }
  }

  instance_template {
    platform_id = "standard-v2"
    resources {
      memory = 4
      cores  = 2
    }

    boot_disk {
      type = "network-ssd"
      size = 50
    }

    network_interface {
      subnet_ids = [
        yandex_vpc_subnet.my_subnet_a.id,
        yandex_vpc_subnet.my_subnet_b.id,
        yandex_vpc_subnet.my_subnet_d.id
      ]
      nat = true
    }
  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  deploy_policy {
    max_unavailable = 1
    max_expansion   = 2
  }
}
