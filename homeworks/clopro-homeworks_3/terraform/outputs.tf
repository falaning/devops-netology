output "bucket_name" {
  value = yandex_storage_bucket.bucket.bucket
}

output "image_url" {
  value = "http://storage.yandexcloud.net/${yandex_storage_bucket.bucket.bucket}/${yandex_storage_object.object.key}"
}

output "instance_group_id" {
  value = yandex_compute_instance_group.group.id
}

output "load_balancer_external_ip" {
  value = yandex_lb_network_load_balancer.nlb.listener.0.address
}
