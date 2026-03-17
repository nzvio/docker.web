# Мультиплатформенный образ (билдится с помощью buildx)
FROM nzvio/ubuntu:24

# Не задавать вопросы при установке
ENV DEBIAN_FRONTEND=noninteractive

# Эти переменные Docker Buildx подставит сам
ARG TARGETOS
ARG TARGETARCH

# Установка пакетов
# Этот образ при установке ставит последние версии CLI Angular и Nest, но CLI не касается самих проектов, так что это не важно, старым проектам это никак не вредит.
# Также ставим postgresql-client-16, т.к. для бэкапов нужна утилита pg_dump
RUN apt-get update && \    
    curl -fsSL https://deb.nodesource.com/setup_24.x -o nodesource_setup.sh && \
    bash nodesource_setup.sh && \
    apt-get install -y nodejs && \
    npm install -g @nestjs/cli && \
    npm install -g @angular/cli && \    
    rm nodesource_setup.sh && \
    apt-get install -y postgresql-client-16 && \
    rm -rf /var/lib/apt/lists/*

# Качаем CLI для хранилища (используется в процедуре бэкапа)
RUN wget https://dl.min.io/client/mc/release/${TARGETOS}-${TARGETARCH}/mc -O /usr/local/bin/mc && \
    chmod +x /usr/local/bin/mc

# При входе в консоль системы попадаем в эту папку.
# Если указать доп. команды в docker-compose, они будут выполняться из этой папки (билды, установки и т.д.).
# Саму папку можно подмонтировать на абсолютно разные реальные папки проекта, в зависимости от дальнейших операций.
# Я специально не называю ее app, чтобы не путаться с папкой, которую я обычно использую для приложений, это именно произвольная папка старта, которая для контейнера - /worker, а реально - всё что угодно.
WORKDIR /worker

# В dev-режиме контейнер с этим образом не будет выполнять никаких процессов, просто висеть как запущенная ОС.
# Чтобы он не завершился после запуска, выполняется эта команда.
CMD ["sleep", "infinity"]