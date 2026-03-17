#!/bin/bash
set -e

# Путь к данным (внутри контейнера)
DATA_DIR="/var/lib/postgresql/16/main"

# 1. Исправляем права на папку (Volume может прийти с правами root)
chown -R postgres:postgres /var/lib/postgresql

# 2. Инициализация, если папка пуста
if [ ! -s "$DATA_DIR/PG_VERSION" ]; then
    # Инициализируем БД от имени пользователя postgres
    su - postgres -c "/usr/lib/postgresql/16/bin/initdb -D $DATA_DIR"    
    # Настройки доступа (ваши шаги 6.2)
    echo "listen_addresses='*'" >> "$DATA_DIR/postgresql.conf"
    echo "host all all 0.0.0.0/0 md5" >> "$DATA_DIR/pg_hba.conf"
    # Временный запуск для настройки
    su - postgres -c "/usr/lib/postgresql/16/bin/pg_ctl -D $DATA_DIR -w start"
    # Создание юзера и базы (шаги 6.1 и 6.4)
    # Используем переменные, которые передадим при запуске
    su - postgres -c "psql --command \"CREATE USER $DB_USER WITH ENCRYPTED PASSWORD '$DB_PASSWORD';\""
    su - postgres -c "psql --command \"CREATE DATABASE $DB_NAME OWNER $DB_USER;\""
    su - postgres -c "psql --command \"ALTER USER postgres WITH PASSWORD '$DB_PASSWORD';\""
    # Останавливаем временный процесс
    su - postgres -c "/usr/lib/postgresql/16/bin/pg_ctl -D $DATA_DIR -m fast stop"
fi

# 3. Запуск основного процесса (вместо systemctl)
exec su - postgres -c "/usr/lib/postgresql/16/bin/postgres -D $DATA_DIR"
