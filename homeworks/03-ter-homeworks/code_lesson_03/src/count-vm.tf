data "yandex_compute_image" "ubuntu" {
  family = var.image_family
}

resource "yandex_compute_instance" "web" {
  count       = 2                        # Создаем две ВМ
  name        = "web-${count.index + 1}" # Назначаем имена web-1 и web-2
  platform_id = var.vm_web_platform_id

  resources {
    cores         = var.web_res["cores"]
    memory        = var.web_res["memory"]
    core_fraction = var.web_res["core_fraction"]
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = [
      yandex_vpc_security_group.example.id
    ]
  }

  allow_stopping_for_update = true

  metadata = {
    user-data = "${file("/Users/boriscernyj/Desktop/documents/Netologia/Git_Netologia/ter-homeworks/03/src/cloud-config.txt")}"
  }
}

