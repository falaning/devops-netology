resource "yandex_storage_bucket" "my_bucket" {
  access_key = var.access_key 
  secret_key = var.secret_key
  bucket = "tf-netology-bucket"
}
