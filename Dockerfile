FROM alpine:latest

# Atualizar repositórios
RUN apk update

# Instalar dependências básicas e libc6-compat
RUN apk add --no-cache \
    wget \
    libstdc++ \
    libx11 \
    libxkbfile \
    libsecret \
    nss \
    alsa-lib \
    libnotify \
    xdg-utils \
    git \
    inotify-tools \
    fuse \
    libc6-compat

# Baixar e instalar libxss de uma fonte compatível
RUN wget http://ftp.us.debian.org/debian/pool/main/libx/libxscrnsaver/libxss1_1.2.3-1_amd64.deb -O /tmp/libxss1.deb && \
    dpkg -i /tmp/libxss1.deb && \
    rm /tmp/libxss1.deb

# Baixar o Obsidian AppImage
RUN wget https://github.com/obsidianmd/obsidian-releases/releases/download/v1.0.3/Obsidian-1.0.3.AppImage -O /usr/local/bin/Obsidian.AppImage

# Tornar o AppImage executável
RUN chmod +x /usr/local/bin/Obsidian.AppImage

# Copiar scripts e arquivos de configuração
COPY auto-commit.sh /usr/local/bin/auto-commit.sh
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY criar_chave_ssh.sh /usr/local/bin/criar_chave_ssh.sh
COPY .env /root/.env

# Tornar os scripts executáveis
RUN chmod +x /usr/local/bin/auto-commit.sh /usr/local/bin/entrypoint.sh /usr/local/bin/criar_chave_ssh.sh

# Definir o diretório de trabalho
WORKDIR /root/Obsidian

# Comando de entrada
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
