#!/bin/sh

# Este script cria uma nova chave SSH e a salva no diretório ~/.ssh/obsidian-git

# Verifique se o usuário forneceu um email como parâmetro
if [ -z "$1" ]; then
    echo "Uso: $0 seuemail@example.com"
    exit 1
fi

EMAIL=$1

# Solicita a senha para proteger a chave SSH
echo "Digite a senha para a chave SSH (ou pressione Enter para nenhuma senha):"
read -s PASSPHRASE

# Cria o diretório ~/.ssh/obsidian-git se não existir
mkdir -p ~/.ssh/obsidian-git

# Gera a chave SSH e salva diretamente no diretório ~/.ssh/obsidian-git
if [ -z "$PASSPHRASE" ]; then
    ssh-keygen -t rsa -b 4096 -C "$EMAIL" -f ~/.ssh/obsidian-git/id_rsa -N ""
else
    ssh-keygen -t rsa -b 4096 -C "$EMAIL" -f ~/.ssh/obsidian-git/id_rsa -N "$PASSPHRASE"
fi

# Mostra a chave pública para o usuário
echo "Chave SSH criada com sucesso!"
echo "A chave pública é:"
cat ~/.ssh/obsidian-git/id_rsa.pub

#configurar ssh
# Adiciona a configuração ao arquivo ~/.ssh/config
cat <<EOL >> ~/.ssh/config

Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/obsidian-git/id_rsa

# Define permissões corretas para o arquivo config
chmod 600 ~/.ssh/config