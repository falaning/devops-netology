###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}


###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "AAAAC3NzaC1lZDI1NTE5AAAAIC773roZeCKgJZOfLb6AQQ8wpW9hUBCdoxyLNA8j+it/"
  description = "ssh-keygen -t ed25519"
}


###my vars for yandex_compute_image

variable "image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "The family of the Yandex Compute image"
}


###my vars for yandex_compute_instance

variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "VM name"
}

variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "platform id"
}

variable "vm_web_core" {
  type        = number
  default     = 2
  description = "core"
}

variable "vm_web_memory" {
  type        = number
  default     = 1
  description = "memory"
}

variable "vm_web_core_fraction" {
  type        = number
  default     = 5
  description = "core_fraction"
}

variable "vm_web_image_id" {
  type        = string
  default     = "data.yandex_compute_image.ubuntu.image_id"
  description = "image_id"
}

variable "vm_web_preemptible" {
  type        = bool
  default     = true
  description = "preemptible"
}

variable "vm_web_nat" {
  type        = bool
  default     = true
  description = "nat"
}


### map vars

variable "vms_resources" {
  description = "Common resources"
  type        = map
  default = {
    web = {
      cores          = 2
      memory         = 1
      core_fraction  = 5
    }
    db = {
      cores          = 2
      memory         = 2
      core_fraction  = 20
    }
  }
}

variable "serial-port-enable" {
  type        = number
  default     = 1 
  description = "Common serial-port-enable"
}
