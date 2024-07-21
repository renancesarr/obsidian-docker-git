# Obsidian Docker com Auto Commit

## Descrição

Este projeto visa fornecer um ambiente isolado e seguro para usar o [Obsidian](https://obsidian.md/), um poderoso editor de markdown para gerenciamento de conhecimento pessoal. Este repositório contém um Dockerfile e scripts associados para configurar o  em um contêiner Docker baseado em Alpine Linux. Ele também inclui uma configuração automatizada de Git para versionamento das notas, realizando commits automáticos sempre que um arquivo for salvo.

## Funcionalidades

- **Obsidian**: Executa o Obsidian em um contêiner Docker.
- **Controle de Versão com Git**: Configura o Git para versionar as notas armazenadas no contêiner.
- **Commits Automáticos**: Utiliza `inotify-tools` para monitorar alterações nos arquivos e realizar commits automáticos sempre que um arquivo é salvo.
- **Sincronização com Repositório Remoto**: Clona e sincroniza automaticamente um repositório Git remoto.

## Configuração

### Pré-requisitos

- Docker instalado no host.
- Conta no GitHub (ou outro provedor de Git) com um repositório configurado.
- Chave SSH configurada para acessar o repositório remoto.

### Passos para Configuração

1. **Clone este repositório:**

   ```sh
   git clone https://github.com/seuusuario/obsidian-docker.git
   cd obsidian-docker
   ```

2. **Chave SSH**

    - **Torne o script criar_chave_ssh.sh executável:**

    ```sh
    chmod +x criar_chave_ssh.sh
    ```

    - **Execute o script fornecendo seu email como parâmetro:**

    ```sh
    ./criar_chave_ssh.sh seuemail@example.com
    ```

3. **Configure o arquivo `.env`**

    Edite o arquivo .env com suas informações de Git:

   ```sh
    GIT_USER_NAME="Seu Nome"
    GIT_USER_EMAIL="seuemail@example.com"
    GIT_REPO="git@github.com:usuario/repo.git"
   ```

4. **Construa e execute o contêiner com Docker Compose:**

    ```sh
    docker-compose up -d
    ```

5. **Script de Facilitação**

    - **Tornar o script executável**

    ```sh
    chmod +x obsidian.sh
    ```

    - **Execute o script**

    ```sh
    sudo ./obsidian.sh
    ```

## Executar

```sh
obsidian
```

## Futuras Tasks

| Tarefa                               | Descrição                                                            | Prioridade |
|--------------------------------------|----------------------------------------------------------------------|------------|
| Melhorar o Script de Auto Commit     | Evitar commits redundantes e melhorar a eficiência de versionamento. | Médio      |
| Monitoramento e Alertas              | Monitoramento e alertas para notificar o sobre  problemas críticos.  | **Alta**   |
| **Criptografia de Notas**            | **Implementar segurança para criptografar as notas no contêiner.**   | **Alta**   |
| Melhoria de Desempenho               | Otimizar o contêiner e os scripts para melhorar o desempenho geral   | Médio      |
| **Integração de Notas com Fluxos de Trabalho e Automação** | **Integre o contêiner do Obsidian com plataformas de automação e fluxos de trabalho, como Zapier, IFTTT e n8n, para criar um sistema de notas que não apenas armazena informações, mas também interage dinamicamente com outras ferramentas e serviços. Isso permitirá automatizar a captura, organização e utilização de informações de maneira mais eficiente e conectada ao seu ecossistema de produtividade.** | **Alta**   |
| Captura Automática de Notas           |  Usar integrações para capturar informações de diferentes fontes    | Médio      |
