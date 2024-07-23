#!/bin/sh

# Verifique se o usuário forneceu um email como parâmetro
if [ -z "$1" ]; then
  echo "Uso: $0 seuemail@example.com"
  exit 1
fi

EMAIL=$1

# Solicita a senha para proteger a chave SSH
echo "Digite a senha para a chave SSH (ou pressione Enter para nenhuma senha):"
read -s PASSPHRASE

# Pergunta qual repositório remoto está sendo usado
echo "Qual repositório remoto você está usando? (github/gitlab/bitbucket)"
read -r REPO_TYPE
REPO_TYPE=${REPO_TYPE:-github}

# Define o host do repositório com base na escolha do usuário
case $REPO_TYPE in
  github)
    REPO_HOST="github.com"
    ;;
  gitlab)
    REPO_HOST="gitlab.com"
    ;;
  bitbucket)
    REPO_HOST="bitbucket.org"
    ;;
  *)
    echo "Tipo de repositório não suportado: $REPO_TYPE"
    exit 1
    ;;
esac

# Cria o diretório ~/.ssh se não existir
mkdir -p ~/.ssh

# Gera a chave SSH e salva diretamente no diretório ~/.ssh
if [ -z "$PASSPHRASE" ]; then
  ssh-keygen -t rsa -b 4096 -C "$EMAIL" -f ~/.ssh/id_rsa -N ""
else
  ssh-keygen -t rsa -b 4096 -C "$EMAIL" -f ~/.ssh/id_rsa -N "$PASSPHRASE"
fi

# Mostra a chave pública para o usuário
echo "Chave SSH criada com sucesso!"
echo "A chave pública é:"
cat ~/.ssh/id_rsa.pub

# Entrar em loop perguntando se a chave foi adicionada ao repositório remoto
while true; do
  echo "Você adicionou a chave pública ao seu repositório remoto ($REPO_HOST)? [s/n] (s é o padrão)"
  read -r ADDED_KEY
  ADDED_KEY=${ADDED_KEY:-s}

  if [ "$ADDED_KEY" = "s" ]; then
    # Testar a conexão com o repositório remoto
    echo "Testando a conexão com o repositório remoto..."
    ssh -T git@$REPO_HOST
    if [ $? -eq 1 ]; then
      echo "Conexão SSH falhou. Verifique se a chave foi adicionada corretamente ao seu repositório remoto."
    else
      echo "Conexão SSH bem-sucedida!"
      break
    fi
  else
    echo "Adicione a chave pública ao seu repositório remoto e responda 's' quando tiver terminado."
  fi
done
