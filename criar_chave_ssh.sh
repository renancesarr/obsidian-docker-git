#!/bin/sh

# Este script cria uma nova chave SSH e a salva no diretório ~/.ssh/

# Verifique se o usuário forneceu um email como parâmetro
if [ -z "$1" ]; then
    echo "Uso: $0 seuemail@example.com"
    exit 1
fi

EMAIL=$1

# Gera a chave SSH sem senha e salva diretamente no diretório ~/.ssh/
ssh-keygen -t rsa -b 4096 -C "$EMAIL" -f ~/.ssh/id_rsa -N ""

# Adiciona a configuração ao arquivo ~/.ssh/config
echo "Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_rsa" >> ~/.ssh/config

# Define permissões corretas para os arquivos
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub
chmod 600 ~/.ssh/config

# Mostra a chave pública para o usuário
echo "Chave SSH criada com sucesso!"
echo "A chave pública é:"
cat ~/.ssh/id_rsa.pub