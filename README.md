# telegram-proxy
Готовый к работе docker-контейнер с прокси для Телеграма на основе Dante

За основу взят образ [wernight/dante](https://hub.docker.com/r/wernight/dante/). В исходном образе настраивается Dante под Alpine Linux, а в этом репозитории ко всему этому добавляется авторизация и ограничение IP адресам, к которым можно подключиться: только к подсети телеграма.

# Установка
Для работы нужен только Docker. Соответственно, поставить можно на любой сервер, где развернут Docker, но для примера возьмем Ubuntu 16.04.

1. Необходимо заказать сервер. Например в vscale.io (там тарифы от 200 р) или DigitalOcean.
2. Далее необходимо залогиниться на сервер под рутом поставить Docker (и заодно unzip, понадобится на следующем шаге):
```sh
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
apt-cache policy docker-ce
sudo apt-get install -y docker-ce unzip
```
3. Скачивание и распаковка этого репозитория:
```sh
wget https://github.com/alexey-sveshnikov/telegram-proxy/archive/master.zip
unzip master.zip
cd telegram-proxy-master
```

4. Правка файла с доступами. Доступы прописываются в файле credentials. Каждый пользователь на отдельной строке. Первое поле в строке - юзернейм, второе (отделенное пробелом или табом) - пароль. Все что дальше - комментарий. Обратите внимание, в файле credentials по умолчанию создается один пользователь с именем username и паролем s3kr3T1234.
Важно: так как для каждой записи создается отдельный системный аккаунт внутри докер-контейнера, после изменения файла credentials, образ необходимо пересобирать.
5. Сборка и запуск:
```sh
./build.sh
./restart.sh
```

Отдельно настраивать запуск прокси после рестарта системы не нужно, это будет сделано самим докером (см. опцию `--restart=always` при запуске контейнера).

Для того, чтобы сгенерировать магические ссылки на конфигурацию прокси, можно запустить скрипт print_tg_links.sh. Для каждой записи из файла credentials он напишет ссылку.

Порт, на котором поднимается прокси, можно поменять в файле restart.sh.

Для просмотра логов можно использовать команду `docker logs socks`.

# Docker compose

1. Установка docker-compose: https://docs.docker.com/compose/install/

2. Для использования с docker compose достаточно перейти в папку с проектом и выполнить:
```
docker-compose up -d --build
```

3. После правки файла credentials, для того чтобы пересобрать образ достаточно выполнить комманду из предыдущего пункта.


# Donats

🍩 BTC: 1BgDn37ngWPXMUfckZAc1THZvMYAqjX4GK

🍩 Ether: 0x8A7368b37B253DC16f161A94c47649C1A7121328
