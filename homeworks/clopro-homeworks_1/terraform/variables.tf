variable "yc_token" {
  description = "Yandex Cloud OAuth token"
}

variable "yc_cloud_id" {
  description = "ID of the Yandex Cloud"
}

variable "yc_folder_id" {
  description = "ID of the Yandex Cloud Folder"
}

variable "yc_zone" {
  description = "Zone where resources will be created"
  default     = "ru-central1-a"
}

variable "path_to_public_key" {
  description = "Path to the public SSH key"
}
