provider "yandex" {
  token     = var.yc_token
  cloud_id  = var.yc_cloud_id
  folder_id = var.yc_folder_id
  zone      = var.yc_zone
}

resource "yandex_vpc_network" "main" {
  name = "my-vpc"
}

resource "yandex_vpc_subnet" "public" {
  name           = "public"
  zone           = var.yc_zone
  network_id     = yandex_vpc_network.main.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

resource "yandex_vpc_subnet" "private" {
  name           = "private"
  zone           = var.yc_zone
  network_id     = yandex_vpc_network.main.id
  v4_cidr_blocks = ["192.168.20.0/24"]
}

resource "yandex_compute_instance" "nat" {
  name          = "nat-instance"
  platform_id   = "standard-v1"
  subnet_id     = yandex_vpc_subnet.public.id
  hostname      = "nat-instance"
  zone          = var.yc_zone
  
  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd80mrhj8fl2oe87o4e1"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.public.id
    nat       = true
    ip_address = "192.168.10.254"
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.path_to_public_key)}"
  }
}

resource "yandex_compute_instance" "public_vm" {
  name          = "public-vm"
  platform_id   = "standard-v1"
  subnet_id     = yandex_vpc_subnet.public.id
  hostname      = "public-vm"
  zone          = var.yc_zone
  allow_stopping_for_update = true
  
  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd80mrhj8fl2oe87o4e1"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.public.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.path_to_public_key)}"
  }
}

resource "yandex_vpc_route_table" "private" {
  name      = "private-route-table"
  network_id = yandex_vpc_network.main.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = "192.168.10.254"
  }
}

resource "yandex_compute_instance" "private_vm" {
  name          = "private-vm"
  platform_id   = "standard-v1"
  subnet_id     = yandex_vpc_subnet.private.id
  hostname      = "private-vm"
  zone          = var.yc_zone
  allow_stopping_for_update = true
  
  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd80mrhj8fl2oe87o4e1"
    }
  }

  network_interface {
    subnet_id      = yandex_vpc_subnet.private.id
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.path_to_public_key)}"
  }
}
