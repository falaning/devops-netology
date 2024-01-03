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
  type        = map(any)
  default = {
    web = {
      cores         = 2
      memory        = 1
      core_fraction = 5
    }
    db = {
      cores         = 2
      memory        = 2
      core_fraction = 20
    }
  }
}

variable "serial-port-enable" {
  type        = number
  default     = 1
  description = "Common serial-port-enable"
}

variable "web_res" {
  type = map(number)
  default = {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }
  description = "Web resources"
}

### each_vm

variable "each_vm" {
  type = list(object({
    name          = string
    cores         = number
    memory        = number
    core_fraction = number
    disk          = string
  }))
  default = [
    { name = "main", cores = 2, memory = 1, core_fraction = 5, disk = "fhmk9jer0i50954pudkp" },
    { name = "replica", cores = 4, memory = 2, core_fraction = 20, disk = "fhm55c69lcltm6ch95so" },
  ]
}


### disk_size

variable "size" {
  type        = number
  default     = 1
  description = "disk size (Gb)"
}


### disk_count

variable "new_disk_count" {
  type        = number
  default     = 3
  description = "disk count"
}

### public_key

variable "public_key" {
  type    = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDEzE7TbV5irENNmmnbO9Sjytg9Cs1G6AKHqxNFmIy0QWSh4O3R6n029TGZVZdHsW5RG6DAVhyTHT/kk4zC6YJGIkBPv1Hrw6ztHk8gFuPYFX9VRqPLIEawV8uuE/Uy10lR6B7L/YTiau8xa07Z6Bg6cpZb1Bv6+9V/hQoOIAhiBKc/FvbqMnIoCH1i1BmSmyYfYX+EAoxXWnOxdIjP+m4VUdMq6okGlxKEBfneU9C+LAsTz72evJNZEssU6uPn7nIJ2EY4utqW33IswKURxPzkSOwo98efu4OJ1Ody/883Gq5/DANkdKv9yaPEI3wQ24TLgJDeX96LdfVtS+MdsRvKYyM6BwHNH4/ZgcqO/leC59TV1qASMYZ/7SJeUN0LbpoNPnmKg63MpeBuN4lrwE22VvzMlK5cCDvcXSQ0vmtUCe9Sj4AgkJ8s75e6znzZmKLi/ALnt7uFxh72J7Cn+Bksgtroki7zsOML/j1QgZ11eUWptRNvB7Q2l8cx2mhl4DM= boriscernyj@MacBook-Air-Boris.local"
}
