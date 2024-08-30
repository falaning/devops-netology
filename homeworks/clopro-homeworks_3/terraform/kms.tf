resource "yandex_kms_secret" "kms-key" {
  name        = "my-kms-key"
  description = "My KMS key for encrypting bucket content"
}
