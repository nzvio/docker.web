# Мультиплатформенный образ (билдится с помощью buildx)
# Переменные окружения, необходимые для работы, подтянутся из внешнего docker-compose, отдельно они тут нигде не фигурируют
FROM nzvio/ubuntu:24

# Не задавать вопросы при установке
ENV DEBIAN_FRONTEND=noninteractive

# Эти переменные Docker Buildx подставит сам
ARG TARGETOS
ARG TARGETARCH

# Качаем бинарник самого сервиса, подставляя архитектуру в путь (linux-amd64 или linux-arm64)
RUN wget https://dl.min.io/server/minio/release/${TARGETOS}-${TARGETARCH}/minio -O /usr/local/bin/minio && \
    chmod +x /usr/local/bin/minio

# Аналогично, качаем CLI
RUN wget https://dl.min.io/client/mc/release/${TARGETOS}-${TARGETARCH}/mc -O /usr/local/bin/mc && \
    chmod +x /usr/local/bin/mc

# Создаем папку для хранения файлов (buckets)
RUN mkdir -p /data

# Копируем скрипт запуска (при сборке образа)
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Порты
EXPOSE 9000 9001

# При старте контейнера выполняется docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]
