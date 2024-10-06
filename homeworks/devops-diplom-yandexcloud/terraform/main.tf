resource "yandex_vpc_network" "my_network" {
  name = "my-network"
}

resource "yandex_vpc_subnet" "my_subnet_a" {
  name           = "my-subnet-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.my_network.id
  v4_cidr_blocks = ["10.0.0.0/24"]
}

resource "yandex_vpc_subnet" "my_subnet_b" {
  name           = "my-subnet-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.my_network.id
  v4_cidr_blocks = ["10.0.1.0/24"]
}

resource "yandex_vpc_subnet" "my_subnet_d" {
  name           = "my-subnet-d"
  zone           = "ru-central1-d"
  network_id     = yandex_vpc_network.my_network.id
  v4_cidr_blocks = ["10.0.2.0/24"]
}
