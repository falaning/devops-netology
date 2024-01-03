# создаём диск для подключения к ВМ
resource "yandex_compute_disk" "disk" {
  count = var.new_disk_count        # Создаем три диска
  name  = "disk-${count.index + 1}" # Назначаем имена disk-1, disk-2 и disk-3
  zone  = "ru-central1-a"
  size  = var.size # Размер диска в гигабайтах
}

# создаём саму ВМ
resource "yandex_compute_instance" "storage" {
  depends_on                = [yandex_compute_disk.disk]
  allow_stopping_for_update = true
  name                      = "storage"
  platform_id               = var.vm_web_platform_id ### в YandexCLoud так называется тип процессора

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

  # с помощью блока dynamic подключаем все 3 диска, автогенерируемых с помощью 'count'
  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.disk # указываем сам 'ресурс' с дисками
    content {
      disk_id = secondary_disk.value.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = [
      yandex_vpc_security_group.example.id
    ]
  }

  metadata = {
    user-data = "${file("/Users/boriscernyj/Desktop/documents/Netologia/Git_Netologia/ter-homeworks/03/src/cloud-config.txt")}"
  }
}
