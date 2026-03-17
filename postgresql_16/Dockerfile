# Мультиплатформенный образ (билдится с помощью buildx)
FROM nzvio/ubuntu:24

# Не задавать вопросы при установке
ENV DEBIAN_FRONTEND=noninteractive

# Установка пакетов
RUN apt-get update && \
    apt-get install -y postgresql-16 postgresql-contrib && \
    rm -rf /var/lib/apt/lists/*

# Создаем структуру папок и даем права пользователю postgres 
# (эта папка примонтируется извне в любом случае, но создаем ее заранее здесь, иначе она примонтируется с другим владельцем)
RUN mkdir -p /var/lib/postgresql/16/main && \
    chown -R postgres:postgres /var/lib/postgresql
    
# Копируем скрипт запуска (при сборке образа)
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Порт
EXPOSE 5432
    
# При старте контейнера выполняется docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]
