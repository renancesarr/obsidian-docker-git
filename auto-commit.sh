#!/bin/sh
# Carregar variáveis do .env
. /root/.env

# Configurar Git
git config --global user.name "$GIT_USER_NAME"
git config --global user.email "$GIT_USER_EMAIL"

# Clonar o repositório
git clone "$GIT_REPO" /root/Obsidian || (cd /root/Obsidian && git pull)

# Monitorar mudanças e fazer commit e push automáticos
inotifywait -m -r -e modify,create,delete --format '%w%f' /root/Obsidian | while read MODIFIED
do
    cd /root/Obsidian
    git add .
    git commit -m "Commit automático: $(date)"
    git push origin master
done
