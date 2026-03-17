# Мультиплатформенный образ (билдится с помощью buildx)
FROM nzvio/ubuntu:24

# Не задавать вопросы при установке
ENV DEBIAN_FRONTEND=noninteractive

# Установка postfix без вопросов
RUN echo "postfix postfix/main_mailer_type string 'Internet Site'" | debconf-set-selections

# Установка доп. пакетов
RUN apt-get update && apt-get install -y \
    postfix \
    mailutils \
    gettext-base \
    && rm -rf /var/lib/apt/lists/*

# Копируем скрипт запуска (при сборке образа)
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
    
# Чтобы postfix не ругался на отсутствие конфига при сборке, создадим пустой
RUN touch /etc/postfix/main.cf

# Порт
EXPOSE 25

# При старте контейнера выполняется docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]
