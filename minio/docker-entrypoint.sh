#!/bin/bash

# Запускаем сервер MinIO в фоне (&)
minio server /data --address :9000 --console-address :9001 &

# Ждем готовности API (порт 9000)
echo "Waiting for MinIO API to be ready..."
until curl -s http://127.0.0.1:9000/minio/health/live; do
    echo "MinIO is starting... (retrying in 1s)"
    sleep 1
done
echo "MinIO API is up! Configuring buckets..."

# Настраиваем mc
mc alias set local http://127.0.0.1:9000 "$MINIO_ROOT_USER" "$MINIO_ROOT_PASSWORD"

# Перебираем бакеты из переменной окружения
for bucket in $MINIO_BUCKETS; do
    echo "Ensuring bucket exists: $bucket"
    mc mb local/"$bucket" --ignore-existing
    mc anonymous set public local/"$bucket"
done

echo "MinIO setup sequence finished."

# Ставим в режим ожидания завершения фонового процесса, чтобы процесс не закрылся
wait
