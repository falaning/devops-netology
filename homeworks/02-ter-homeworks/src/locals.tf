locals {
  vm_names = {
    web_vm_name = "${var.vm_web_name}"
    db_vm_name  = "${var.vm_db_name}"
  }
  ssh_keys_value = "ubuntu:${var.vms_ssh_root_key}"
}
