#!/bin/sh

# Solicitar variáveis de ambiente ao usuário
read -p "Digite seu nome de usuário do Git: " GIT_USER_NAME
read -p "Digite seu email do Git: " GIT_USER_EMAIL
read -p "Digite a URL do repositório Git: " GIT_REPO

# Criar ou atualizar o arquivo .env com as variáveis de ambiente fornecidas
cat <<EOF > .env
GIT_USER_NAME=${GIT_USER_NAME}
GIT_USER_EMAIL=${GIT_USER_EMAIL}
GIT_REPO=${GIT_REPO}
EOF

IMAGE_NAME="obsidian-alpine-git"
DOCKER_COMPOSE_FILE="docker-compose.yml"

# Verificar se a imagem Docker existe
if ! docker images | grep -q "$IMAGE_NAME"; then
  echo "Imagem Docker '$IMAGE_NAME' não encontrada. Construindo a imagem..."
  docker build -t $IMAGE_NAME .
else
  echo "Imagem Docker '$IMAGE_NAME' encontrada."
fi

# Executar docker-compose up -d
docker-compose -f $DOCKER_COMPOSE_FILE up -d
