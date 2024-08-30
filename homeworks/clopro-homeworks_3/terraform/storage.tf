resource "yandex_storage_bucket" "my_bucket" {
  access_key       = var.yc_storage_access_key
  secret_key       = var.yc_storage_secret_key
  bucket           = "my-encrypted-bucket"
  max_size         = 100
}

resource "yandex_storage_object" "encrypted_object" {
  bucket = yandex_storage_bucket.my_bucket.bucket
  key    = "my_encrypted_data.txt"
  content = base64encode(
    jsonencode({
      "example_key" = "example_value"
    })
  )

  server_side_encryption {
    algorithm     = "AES256"
    kms_key_id    = yandex_kms_secret.kms-key.id
  }
}
