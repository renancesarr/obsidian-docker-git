FROM alpine:latest

# Instalar dependências
RUN apk add --no-cache \
    wget \
    libstdc++ \
    libx11 \
    libxkbfile \
    libsecret \
    nss \
    alsa-lib \
    libnotify \
    libxss \
    xdg-utils \
    git \
    inotify-tools \
    && apk add --no-cache --virtual .build-deps \
    dpkg \
    && wget https://github.com/obsidianmd/obsidian-releases/releases/download/v1.0.3/obsidian_1.0.3_amd64.deb \
    && dpkg -i obsidian_1.0.3_amd64.deb \
    && apk del .build-deps \
    && rm obsidian_1.0.3_amd64.deb

# Instalar Rclone
RUN apk add --no-cache rclone

# Copiar scripts e arquivos de configuração
COPY auto_commit.sh /usr/local/bin/auto_commit.sh
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY .env /root/.env

# Adicionar chave SSH
COPY ssh/obsidian-git/id_rsa /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa

# Tornar os scripts executáveis
RUN chmod +x /usr/local/bin/auto_commit.sh /usr/local/bin/entrypoint.sh

# Definir o diretório de trabalho
WORKDIR /root/Obsidian

# Comando de entrada
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
