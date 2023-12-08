###my vars for yandex_compute_instance (VM2 "db")"

variable "vm_db_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "VM name"
}

variable "vm_db_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "platform id"
}

variable "vm_db_core" {
  type        = number
  default     = 2
  description = "core"
}

variable "vm_db_memory" {
  type        = number
  default     = 2
  description = "memory"
}

variable "vm_db_core_fraction" {
  type        = number
  default     = 20
  description = "core_fraction"
}

variable "vm_db_image_id" {
  type        = string
  default     = "data.yandex_compute_image.ubuntu.image_id"
  description = "image_id"
}

variable "vm_db_preemptible" {
  type        = bool
  default     = true
  description = "preemptible"
}

variable "vm_db_nat" {
  type        = bool
  default     = true
  description = "nat"
}
