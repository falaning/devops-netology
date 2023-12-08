resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}


data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2004-lts"
}


# ВМ 1

resource "yandex_compute_instance" "platform" {
  name        = local.vm_names.web_vm_name
  platform_id = var.vm_web_platform_id
  resources {
    cores         = var.vms_resources["web"]["cores"]
    memory        = var.vms_resources["web"]["memory"]
    core_fraction = var.vms_resources["web"]["core_fraction"]
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id 
    }
  }
  scheduling_policy {
    preemptible = var.vm_web_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_web_nat 
  }

 metadata = {
    serial-port-enable = var.serial-port-enable
    ssh-keys = local.ssh_keys_value
  } 

}


# ВМ 2

resource "yandex_compute_instance" "VM2" {
  name        = local.vm_names.db_vm_name
  platform_id = var.vm_db_platform_id
  resources {
    cores         = var.vms_resources["db"]["cores"]
    memory        = var.vms_resources["db"]["memory"]
    core_fraction = var.vms_resources["db"]["core_fraction"]
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id 
    }
  }
  scheduling_policy {
    preemptible = var.vm_web_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_web_nat 
  }

  metadata = {
    serial-port-enable = var.serial-port-enable
    ssh-keys = local.ssh_keys_value
  }
}
