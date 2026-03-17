# Мультиплатформенный образ (билдится с помощью buildx)
FROM ubuntu:24.04

# Не задавать вопросы при установке
ENV DEBIAN_FRONTEND=noninteractive

# Автоматический аргумент от buildx
ARG TARGETARCH

# Установка часто используемых пакетов
# Принято использовать apt-get, а не apt - вроде как стабильнее и меньше мусорит в консоль.
RUN apt-get update && \
    apt-get install -y \
    curl \
    wget \
    ca-certificates \
    tzdata \    
    locales \
    gnupg \
    net-tools \
    zip \
    build-essential \
    htop \
    cron \
    && rm -rf /var/lib/apt/lists/*

# Установка watchexec v2.5.0
RUN if [ "$TARGETARCH" = "arm64" ]; then \
        W_ARCH="aarch64"; \
    else \
        W_ARCH="x86_64"; \
    fi && \
    wget https://github.com/watchexec/watchexec/releases/download/v2.5.0/watchexec-2.5.0-${W_ARCH}-unknown-linux-gnu.deb -O /tmp/watchexec.deb && \
    apt-get update && apt-get install -y /tmp/watchexec.deb && \
    rm /tmp/watchexec.deb && \
    rm -rf /var/lib/apt/lists/*

# Установка кодировок
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
