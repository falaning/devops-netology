## Задачи

### Подготовка к выполнению

1. Создайте два VM в Yandex Cloud с параметрами: 2CPU 4RAM Centos7 (остальное по минимальным требованиям).
2. Пропишите в inventory playbook созданные хосты.
3. Добавьте в files файл со своим публичным ключом (id_rsa.pub). Если ключ называется иначе — найдите таску в плейбуке, которая использует id_rsa.pub имя, и исправьте на своё.
4. Запустите playbook, ожидайте успешного завершения.
5. Проверьте готовность SonarQube через браузер.
6. Зайдите под admin\admin, поменяйте пароль на свой.
7. Проверьте готовность Nexus через бразуер.
8. Подключитесь под admin\admin123, поменяйте пароль, сохраните анонимный доступ.

### Знакомоство с SonarQube

#### Основная часть

1. Создайте новый проект, название произвольное.
2. Скачайте пакет sonar-scanner, который вам предлагает скачать SonarQube.
3. Сделайте так, чтобы binary был доступен через вызов в shell (или поменяйте переменную PATH, или любой другой, удобный вам способ).
4. Проверьте sonar-scanner --version.
5. Запустите анализатор против кода из директории example с дополнительным ключом -Dsonar.coverage.exclusions=fail.py.
6. Посмотрите результат в интерфейсе.
7. Исправьте ошибки, которые он выявил, включая warnings.
8. Запустите анализатор повторно — проверьте, что QG пройдены успешно.
9. Сделайте скриншот успешного прохождения анализа, приложите к решению ДЗ.

### Знакомство с Nexus

#### Основная часть

1. В репозиторий maven-public загрузите артефакт с GAV-параметрами:

- groupId: netology;
- artifactId: java;
- version: 8_282;
- classifier: distrib;
- type: tar.gz.

2. В него же загрузите такой же артефакт, но с version: 8_102.
3. Проверьте, что все файлы загрузились успешно.
4. В ответе пришлите файл maven-metadata.xml для этого артефекта.

### Знакомство с Maven

#### Подготовка к выполнению

1. Скачайте дистрибутив с maven.
2. Разархивируйте, сделайте так, чтобы binary был доступен через вызов в shell (или поменяйте переменную PATH, или любой другой, удобный вам способ).
3. Удалите из apache-maven-<version>/conf/settings.xml упоминание о правиле, отвергающем HTTP- соединение — раздел mirrors —> id: my-repository-http-unblocker.
4. Проверьте mvn --version.
5. Заберите директорию mvn с pom.

#### Основная часть

1. Поменяйте в pom.xml блок с зависимостями под ваш артефакт из первого пункта задания для Nexus (java с версией 8_282).
2. Запустите команду mvn package в директории с pom.xml, ожидайте успешного окончания.
3. Проверьте директорию ~/.m2/repository/, найдите ваш артефакт.
4. В ответе пришлите исправленный файл pom.xml.

----------------------------------------------------------------------------------------------------

## Ответ

### Подготовка к выполнению

1. Создал две VM в Yandex Cloud с параметрами: 2CPU 4RAM Centos7

![vm_yandex.png](screenshots/vm_yandex.png)

2. Прописал в inventory playbook мои хосты.

3. Добавил в files файл со своим публичным ключом.

4. Успешно запустил playbook.

![playbook.png](screenshots/playbook.png)

5. SonarQube запустился.

6. Зашёл под admin\admin и поменял пароль на свой.

7. Nexus запустился.

8. Подключился под admin\admin123 и поменял пароль, сохранив анонимный доступ.

### Знакомоство с SonarQube

#### Основная часть

1. Создал проект с названием `netology`

2. Скачал пакет sonar-scanner.

![sc.png](screenshots/sc.png)

3. Сделал вызов бинарника через консоль (добавив его в bin директорию).

4. Команда `sonar-scanner --version` отработала успешно.

![scv.png](screenshots/scv.png)

5. Запустил анализатор против кода с ключом `-Dsonar.coverage.exclusions=fail.py`.

![analyze.png](screenshots/analyze.png)

6. Зафиксировал результат в интерфейсе.

![interf.png](screenshots/interf.png)

7. Исправил ошибки, включая warnings.

![interf_errors.png](screenshots/interf_errors.png)

8. Запустил анализатор повторно — QG пройдены успешно.

![analyze_ok.png](screenshots/analyze_ok.png)

9. Сделайте скриншот успешного прохождения анализа, приложите к решению ДЗ.

![interf_ok.png](screenshots/interf_ok.png)

### Знакомство с Nexus

#### Основная часть

1. В репозиторий maven-public загрузил артефакт с GAV-параметрами:

```
- groupId: netology;
- artifactId: java;
- version: 8_282;
- classifier: distrib;
- type: tar.gz.
```

![nexus_download.png](screenshots/nexus_download.png)

Сам артефакт (с простым java-кодом "Привет, мир!"):

![art_jar.png](screenshots/art_jar.png)

2. В этот же репозиторий загрузил такой же артефакт, но с version: 8_102.

![nexus_download2.png](screenshots/nexus_download2.png)

3. Все файлы загрузились успешно.

4. Файл `maven-metadata.xml` для этого артефекта можно найти в этой же директории, где и `README.md` файл.

![maven_xml.png](screenshots/maven_xml.png)

### Знакомство с Maven

#### Подготовка к выполнению

1. Скачал дистрибутив с `maven`.

![maven_download.png](screenshots/maven_download.png)

2. Разархивировал программу и сделал её бинарник доступным для вызова из консоли.

![maven_bin.png](screenshots/maven_bin.png)

3. Удалил из `apache-maven-3.9.6/conf/settings.xml` упоминание о правиле, отвергающем HTTP- соединение — раздел `mirrors —> id: my-repository-http-unblocker.`

![maven_delete.png](screenshots/maven_delete.png)

4. Запустил команду `mvn --version`.

![maven_version.png](screenshots/maven_version.png)

5. Забрал директорию `mvn` с `pom.xml`.

#### Основная часть

1. Поменял в `pom.xml` блок с зависимостями под мой артефакт (java с версией 8_282).

![pom_xml.png](screenshots/pom_xml.png)

2. Успешно запустил команду `mvn package`.

![mvn_package.png](screenshots/mvn_package.png)

3. Проверил директорию `~/.m2/repository/` и нашёл там свой артефакт.

![final_art.png](screenshots/final_art.png)

4. Исправленный файл `pom.xml` находится по пути: `mvn/pom.xml`. Также в общей директории `09-ci-03-cicd` можно найти логи выполнения команд `sonar-scanner` и `mvn package` (`pom_xml_logs.txt` и `sonar-test-logs.txt`)

#### Домашнее задание выполнил успешно

Всё его выполнение описано в данном `README.md` файле в текущем моём репозитории.
