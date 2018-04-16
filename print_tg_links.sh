cat credentials  | while read user pass; do echo "tg://socks?server=tuchki.ru&port=41195&user=$user&pass=$pass"; done
