output "instance_ips" {
  value = {
    web_vm_ip = yandex_compute_instance.platform.network_interface.0.nat_ip_address
    db_vm_ip  = yandex_compute_instance.VM2.network_interface.0.nat_ip_address
  }
}


