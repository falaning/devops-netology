## Домашняя работа

#### Задание 1. Создать Pod с именем hello-world

1) Создать манифест (yaml-конфигурацию) Pod.
2) Использовать image - gcr.io/kubernetes-e2e-test-images/echoserver:2.2.
3) Подключиться локально к Pod с помощью kubectl port-forward и вывести значение (curl или в браузере).

#### Ответ

1) Создал манифест файл

![manifest.png](screenshots/manifest.png)

2) В нём использовать image `gcr.io/kubernetes-e2e-test-images/echoserver:2.2`.

![image.png](screenshots/image.png)

3) Подключился локально к Pod с помощью `kubectl port-forward`.

Port-forward:
![port-forward.png](screenshots/port-forward.png)

Curl:
![curl.png](screenshots/curl.png)

Также решил дополнителньо получить доступ к pod через браузер путём изменения типа сервиса на NodePort.

Для этого создал новый манифест для pod:

![manifest_public.png](screenshots/manifest_public.png)

И ещё один новый манифест для сервиса:

![manifest_service.png](screenshots/manifest_service.png)

И в итоге получил доступ к pod через браузер, увидел эту страницу:

![web.png](screenshots/web.png)

#### Задание 2. Создать Service и подключить его к Pod

1) Создать Pod с именем netology-web.
2) Использовать image — gcr.io/kubernetes-e2e-test-images/echoserver:2.2.
3) Создать Service с именем netology-svc и подключить к netology-web.
4) Подключиться локально к Service с помощью kubectl port-forward и вывести значение (curl или в браузере).

#### Ответ

1) Создал Pod с именем `netology-web`

![pod_netology_web.png](screenshots/pod_netology_web.png)

2) Использовал image — `gcr.io/kubernetes-e2e-test-images/echoserver:2.2`.

![image_web.png](screenshots/image_web.png)

3) Создал Service с именем `netology-svc`,

![service_web.png](screenshots/service_web.png)

и подключил его к `netology-web` с помощью селектора:

```
spec:
  selector:
    app: netology-web
```

4) Подключился к Service с помощью метода изменения типа сервиса на `NodePort` (вместо port-forward) для того чтобы получить доступ к странице через браузер:

![web_2.png](screenshots/web_2.png)

Список pods:

![get_pods.png](screenshots/get_pods.png)
