### LEGACY код

resource "null_resource" "web_hosts_provision" {
  #Ждем создания инстанса
  depends_on = [yandex_compute_instance.web, yandex_compute_instance.db, yandex_compute_instance.storage]

  #Добавление ПРИВАТНОГО ssh ключа в ssh-agent
  provisioner "local-exec" {
    command = "cat ~/.ssh/id_rsa | ssh-add -"
  }

  provisioner "local-exec" {
    command = "echo '!!!IT WORKS!!!'"
  }

  #Костыль!!! Даем ВМ 60 сек на первый запуск. Лучше выполнить это через wait_for port 22 на стороне ansible
  # В случае использования cloud-init может потребоваться еще больше времени
  provisioner "local-exec" {
    command = "sleep 60"
  }

  #Запуск ansible-playbook
  provisioner "local-exec" {
    command     = "export ANSIBLE_HOST_KEY_CHECKING=False; ansible-playbook -i /Users/boriscernyj/Desktop/documents/Netologia/Git_Netologia/ter-homeworks/03/src/hosts.cfg /Users/boriscernyj/Desktop/documents/Netologia/Git_Netologia/ter-homeworks/03/src/test.yml"
    on_failure  = continue #Продолжить выполнение terraform pipeline в случае ошибок
    environment = { ANSIBLE_HOST_KEY_CHECKING = "False" }
    #срабатывание триггера при изменении переменных
  }
  triggers = {
    always_run        = "${timestamp()}"                                                                                   #всегда т.к. дата и время постоянно изменяются
    playbook_src_hash = file("/Users/boriscernyj/Desktop/documents/Netologia/Git_Netologia/ter-homeworks/03/src/test.yml") # при изменении содержимого playbook файла
    ssh_public_key    = var.public_key                                                                                     # при изменении переменной
  }

}

### Создаём inventory-file для ansible с помощью ресурса "local_file":
### и передаём в качестве переменных группы ВМ (всего 5 ВМ).

###   resource "local_file" - это ресурс, который позволяет создавать файлы (но не удалять) и считывать с них данные 
###   hosts.tfpl - это файл-шаблон (мы его здесь "передаём" ресурсу "local_file")
###   hosts.cfg - это наш инвентори файл (чисто файл Ansibl'а), который создастся благодаря ресурсу "local_file"


resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/hosts.tftpl", {
    webservers     = yandex_compute_instance.web
    dbservers      = yandex_compute_instance.db
    storageservers = yandex_compute_instance.storage
  })
  filename = "${abspath(path.module)}/hosts.cfg"
}

###  dbservers      = yandex_compute_instance.db
###  storageservers = yandex_compute_instance.storage



