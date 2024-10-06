resource "yandex_container_registry" "default" {
  name = "test-registry"
  folder_id = var.folder_id
}

output "registry_id" {
  value = yandex_container_registry.default.id
}   
