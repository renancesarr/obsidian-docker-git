#!/bin/sh

# Carregar variáveis do .env
. /root/.env

# Executar o script criar_chave_ssh.sh com o email do .env
/usr/local/bin/criar_chave_ssh.sh "$GIT_USER_EMAIL"

# Configurar Git
git config --global user.name "$GIT_USER_NAME"
git config --global user.email "$GIT_USER_EMAIL"

# Adicionar chave SSH
eval $(ssh-agent -s)
ssh-add /root/.ssh/obsidian-ssh/id_rsa

# Clonar o repositório
git clone "$GIT_REPO" /root/Obsidian || (cd /root/Obsidian && git pull)

# Iniciar o script de auto commit em segundo plano
nohup /usr/local/bin/auto-commit.sh &

# Iniciar o Obsidian
/usr/local/bin/Obsidian.AppImage
