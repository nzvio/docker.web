#!/bin/bash

# 1. Устанавливаем системное имя почты
echo "$MAIL_DOMAIN" > /etc/mailname

# 2. Генерируем конфиг main.cf на лету (используем postconf — это надежнее правки файлов)
postconf -e "myhostname = $MAIL_DOMAIN"
postconf -e "myorigin = /etc/mailname"
postconf -e "mydestination = localhost, $MAIL_DOMAIN"
postconf -e "mynetworks = 127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128 172.16.0.0/12 192.168.0.0/16"
postconf -e "inet_interfaces = all"
postconf -e "inet_protocols = ipv4"
postconf -e "maillog_file = /dev/stdout"
postconf -F '*/*/chroot = n' # чтобы postfix читал системные файлы перед запуском

# 3. Запускаем postfix в режиме foreground
exec postfix start-fg
