## Домашняя работа

#### Задание 1. Создание облачной инфраструктуры

##### 1) Создал сервисный аккаунт для terraform

С именем `terraform-sa`

![service_account.png](screenshots/service_account.png)

Выставил ему роль `editor`

![sa_roles.png](screenshots/sa_roles.png)

Создал статический ключ для сервисного аккаунта:

![key.png](screenshots/key.png)

##### 2) Подготовил backend для Terraform

1. Перед созданием бакета создал для него сервисный аккаунт `object-storage-sa`, выдал для него роли `editor` и `storage.admin`

![sa_s3.png](screenshots/sa_s3.png)

Вывод команды `terraform apply`:

![terraform_log_3.png](screenshots/terraform_log_3.png)

Созданный bucket в Yandex Cloud:

![my_bucket.png](screenshots/my_bucket.png)

##### 3) Создал VPC с подсетями в разных зонах доступности

Вывод команды `terraform apply`:

![terraform_log_1.png](screenshots/terraform_log_1.png)

![terraform_log_2.png](screenshots/terraform_log_2.png)

Созданная VPC `my-network` с двумя подсетями в разных зонах доступности: `my-subnet-a` и `my-subnet-b`:

![vpc_1.png](screenshots/vpc_1.png)

##### 4) Убедился, что я могу выполнить команды `terraform destroy` и `terraform apply` без дополнительных ручных действий

Выполненная команда `terraform destroy`:

![terrafrom_destroy.png](screenshots/terrafrom_destroy.png)

Выполненная команда `terraform apply`:

![terraform_apply.png](screenshots/terraform_apply.png)

#### Задание 2. Создание Kubernetes кластера

##### 1) С помощью terraform resource для kubernetes создал региональный мастер kubernetes с размещением нод в разных 3 подсетях

Для начала подготовил сервис аккаунты с соответствующими ролями:

![service_accounts.png](screenshots/service_accounts.png)

Кластер:

![k8s_cluster.png](screenshots/k8s_cluster.png)

3 разные подсети:

![k8s_subnets.png](screenshots/k8s_subnets.png)

##### 2) С помощью terraform resource для kubernetes создал node group

Группа нод

![k8s_node_group.png](screenshots/k8s_node_group.png)

Разные подсети

![k8s_nodes.png](screenshots/k8s_nodes.png)

Скриншот разных подсетей из настройки групп нод

![k8s_node_subnets.png](screenshots/k8s_node_subnets.png)

##### 3) Работоспособный Kubernetes кластер

Кластер из yandex cloud работает, мастер отправляет метрики:

![k8s_metrics.png](screenshots/k8s_metrics.png)

##### 4) В файле ~/.kube/config находятся данные для доступа к кластеру

Кластер инициализирован:

![k8s_info.png](screenshots/k8s_info.png)

##### 5) Команда kubectl get pods --all-namespaces отрабатывает `просто идеально`

![k8s_get_nodes.png](screenshots/k8s_get_nodes.png)

#### Задание 3. Создание тестового приложения

Я решил воспользоваться "Рекомендуемым вариантом", указанным в задании.

##### 1)  Создал отдельный git репозиторий с простым nginx конфигом, который отдаваёт статический контент

Создал публичный репозиторий ```configs``` в котором и разместил **nginx** конфиг, html-код и dockerfile собирающий образ приложения:

![new_repo.png](screenshots/new_repo.png)

##### 2)  Подготовил Dockerfile для создания образа приложения

![dockerfile.png](screenshots/dockerfile.png)

Он влкючает в себя конфигурацию nginx:

![nginx_conf.png](screenshots/nginx_conf.png)

И директорию с html-страницей `html/index.html`, на которой будет написано `It works!`:

![html_web_page.png](screenshots/html_web_page.png)

##### 3) Собрал образ

Собрал образ при помощи команды `docker build --platform linux/amd64 -t cr.yandex/crp581po20a0rccbh4g6/test-nginx-app:latest .`

Здесь стоит обратить внимание что использовался параметр `--platform linux/amd64` чтобы явно указать для какой платформы будет происходить сборка. Без этого параметра деплой образа в k8s (сервис Yandex Cloud) выдавал ошибку, видимо это связанно с особенностью серверной архитектуры самого Yandex Cloud. После указания флага всё заработало.

![html_web_page.png](screenshots/html_web_page.png)

##### 4) Подключил Docker к Container Registry

Для этого использовал метод подключения `yc container registry configure-docker`

![docker_login.png](screenshots/docker_login.png)

Так как при подключении через `docker login cr.yandex` я получал ошибку, где советовался метод описанный выше:

```
~ docker login cr.yandex

Authenticating with existing credentials...
ERROR: docker login is not supported with yc credential helper. Use 'yc container registry configure-docker --profile <PROFILE>' to set another profile or disable credential helper for given endpoint: https://cloud.yandex.ru/docs/container-registry/operations/authentication#ch-not-use
Error saving credentials: error storing credentials - err: exit status 1, out: ``
```

##### 5) Ссылка на Git репозиторий с тестовым приложением и Dockerfile

<https://github.com/falaning/configs>

##### 6) Мой регистри с собранным docker image

В качестве регистри я выбрал Yandex Container Registry, созданный также с помощью terraform.

Код terraform:

![tf_registry.png](screenshots/tf_registry.png)

Регистри на Yandex Cloud:

![yc_registry.png](screenshots/yc_registry.png)

#### Задание 4. Подготовка cистемы мониторинга и деплой приложения

##### 1) Задеплоил в кластер prometheus, grafana, alertmanager, экспортер основных метрик Kubernetes

Для этого вопсользовался пакетом `kube-prometheus`.

Задеплоил пакет:

`kubectl apply -f manifests`

![k8s_deploy_prometheus.png](screenshots/k8s_deploy_prometheus.png)

Затем для того чтобы получить доступ к web запустил `port-forwarding` на `3000` порту:

`kubectl port-forward svc/grafana 3000:3000 -n monitoring`

![k8s_port_forwarding.png](screenshots/k8s_port_forwarding.png)

Подключился по адресу `http://localhost:3000/`, авторизовался дефолт-кредами, получил доступ к `Grafana`:

![prometheus_web.png](screenshots/prometheus_web.png)

Создал **playlist** с простыми **dashboards**, отображающие состояние кластера **kubernetes**:

![grafana_dashboards.png](screenshots/grafana_dashboards.png)

##### 2) Задеплоил тестовое приложение (nginx сервер отдающий статическую страницу)

Для этого в репозитории `configs` создал манифест-файл `kubernetes/nginx/nginx.yaml`, который создаёт `deployment` моего `nginx-приложения` и `service` для **LoadBalancer** чтобы делать балансировку между двумя репликами приложения (для отказоустойчивости):

![k8s_manifest_nginx.png](screenshots/k8s_manifest_nginx.png)

Применил манифест-файл и успешно создал deployment `my-nginx-app`,

![k8s_deployments.png](screenshots/k8s_deployments.png)

состоящий из 2 подов:

![k8s_pods.png](screenshots/k8s_pods.png)

Затем, чтобы подключиться к web-странице приложения, ввёл команду `kubectl get svc` и получил `EXTERNAL-IP` для подключения,

![k8s_svc.png](screenshots/k8s_svc.png)

порт 80, так как в Dockerfile было прописано `EXPOSE 80`:

![docker_expose_port.png](screenshots/docker_expose_port.png)

Затем подключился по этому IP-адресу через браузер, и увидел страницу моего web-приложения на которой, соответственно, написано `It works!`:

![app_web_page.png](screenshots/app_web_page.png)

#### Задание 5. Установка и настройка CI/CD

Настроил ci/cd систему для автоматической сборки **docker image** и деплоя приложения при изменении кода.

В качестве системы выбрал `GitHub Actions`.

##### 1) Сделал автоматическую сборку docker образа при коммите в Github репозиторий с тестовым nginx-приложением

Для этого я написал **workflow** `/configs/.github/workflows/docker-build-and-push.yml`:

![github_workflow.png](screenshots/github_workflow.png)

Путём проб и ошибок успешно запустил его с 7 раза. Основные проблемы возникали сначала из-за ошибок в `yaml` синтаксе, затем **workflow** стал успешно запускаться но **push** в репозиторий создавал сразу 3 ***"images"*** вместо 1. Оказывается, это было из-за использования утилиты `docker buildx` в **workflow** (расширенной вресии `docker build`). Из-за своей специфики она создаёт во время сборки помимо **image** ещё 2 файла метаданных, которые тоже **push**ились в `container registry` (и соответственно воспринимались им как **images**).

Проблема решилась путём замены `docker buildx` на традиционный `docker build`, после чего **images** стали **push**иться и отображаться корректно.

![github_workflow_2.png](screenshots/github_workflow_2.png)

Скриншот из `container registry` с **image**:

![cr_2.png](screenshots/cr_2.png)

##### 2) Сделал автоматический деплой нового docker образа
