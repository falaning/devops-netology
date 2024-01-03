resource "yandex_compute_instance" "db" {
  depends_on                = [yandex_compute_instance.web]
  allow_stopping_for_update = true
  for_each                  = { for vm in var.each_vm : vm.name => vm }
  name                      = each.value.name
  platform_id               = var.vm_web_platform_id ### в YandexCLoud так называется тип процессора

  resources {
    cores         = each.value.cores
    memory        = each.value.memory
    core_fraction = each.value.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  secondary_disk {
    disk_id = each.value.disk
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


### чтобы создать ресурс "disk"
/*
resource "yandex_compute_disk" "example" {
  name = "example-disk"
  zone = "ru-central1-a"
  size = 20    # Размер диска в гигабайтах
}
*/

### чтобы приатачить описываемый здесь диск к описываемой ВМ (если ВМ одна, а не несколько ((благодаря for_each)))
/*
secondary_disk {
    disk_id = yandex_compute_disk.example.id
  }
*/

