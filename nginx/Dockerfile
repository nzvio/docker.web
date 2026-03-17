# Мультиплатформенный образ (билдится с помощью buildx)
FROM nzvio/ubuntu:24

# Не задавать вопросы при установке
ENV DEBIAN_FRONTEND=noninteractive

# Установка пакетов
RUN apt-get update && apt-get install -y \
    nginx \
    libnginx-mod-http-brotli-filter \
    libnginx-mod-http-brotli-static \
    certbot \
    python3-certbot-nginx \
    && rm -rf /var/lib/apt/lists/*

# Копируем скрипт запуска (при сборке образа)
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Перенаправление логов на стандартный вывод
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

# Порты
EXPOSE 80 443

# При старте контейнера выполняется docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]
