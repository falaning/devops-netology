
### Данный файл создан для тестирования создания диска и моментального его аттачинга к вм (которая тоже создаётся здесь же)

/*
resource "yandex_compute_disk" "test_disk" {
  name = "example-disk"
  type = "network-hdd"
  zone = "ru-central1-a"
  size = 20    # Размер диска в гигабайтах
}

resource "yandex_compute_instance" "test_vm" {
  name        = "test"
  platform_id = "standard-v1"
  resources {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  secondary_disk {
    disk_id = yandex_compute_disk.test_disk.id
  }
  
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    security_group_ids = [
      yandex_vpc_security_group.example.id
    ]
  }
}
*/