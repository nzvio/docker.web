#!/bin/bash

# Берем первый домен из списка для проверки наличия папки
FIRST_DOMAIN=$(echo $DOMAINS | awk '{print $1}')

# Проверяем, есть ли уже сертификат
if [ ! -d "/etc/letsencrypt/live/$FIRST_DOMAIN" ]; then
    echo "Certificates not found. Starting certbot for: $DOMAINS"
    nginx # Запускаем в фоне для проверки
    
    CERT_ARGS=""
    for DOMAIN in $DOMAINS; do
        CERT_ARGS="$CERT_ARGS -d $DOMAIN"
    done

    certbot --nginx $CERT_ARGS -m "$EMAIL" --agree-tos --non-interactive --redirect    
    nginx -s stop
else
    echo "Certificates for $FIRST_DOMAIN already exist. Skipping certbot."
fi

service cron start
echo "Starting Nginx."
nginx -g "daemon off;"
