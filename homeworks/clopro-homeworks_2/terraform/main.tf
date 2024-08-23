provider "yandex" {
  token     = "<MY_YANDEX_CLOUD_TOKEN>"
  cloud_id  = "b1gerteuvwjergj4ngcd43"
  folder_id = "b1wgegwe4fswg33gdg8gfh"
}

resource "yandex_storage_bucket" "bucket" {
  bucket = "borischerny210824"
  acl     = "public-read"
}

resource "yandex_storage_object" "object" {
  bucket = yandex_storage_bucket.bucket.bucket
  key    = "image.jpg"
  source = "path/to/your/image.jpg"
  acl    = "public-read"
}

resource "yandex_compute_instance_group" "group" {
  name        = "my-lamp-group"
  folder_id   = var.folder_id
  instance_template {
    platform_id  = "standard-v1"
    compute_resources {
      memory = 4
      cores  = 2
    }
    boot_disk {
      initialize_params {
        image_id = "fd827b91d99psvq5fjit"
      }
    }
    network_interface {
      network_id = var.network_id
      subnet_ids = [var.subnet_id]
      nat        = true
    }
    scheduling_policy {
      preemptible = false
    }
    metadata = {
      user_data = <<-EOF
        #!/bin/bash
        echo "<html>
        <head><title>Image</title></head>
        <body>
        <h1>Hello, this is a test page</h1>
        <img src='http://storage.yandexcloud.net/borischerny210824/image.jpg' />
        </body>
        </html>" > /var/www/html/index.html
      EOF
    }
  }
  scale_policy {
    fixed_scale {
      size = 3
    }
  }
}

resource "yandex_compute_instance_group_health_check" "hc" {
  instance_group_id    = yandex_compute_instance_group.group.id
  interval             = 10
  timeout              = 5
  unhealthy_threshold  = 5
  healthy_threshold    = 2
  http_options {
    path = "/"
    port = "80"
  }
}

resource "yandex_lb_network_load_balancer" "nlb" {
  folder_id = var.folder_id
  name        = "my-nlb"
  region      = "ru-central1"
  listener {
    name        = "http"
    port        = 80
    protocol    = "HTTP"
    target_group {
      target {
        address = yandex_compute_instance_group.group.instances.*.network_interface.0.ip_address
        port    = 80
      }
    }
  }
}

output "load_balancer_external_ip" {
  value = yandex_lb_network_load_balancer.nlb.listener.0.address
}
