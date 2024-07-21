#!/bin/sh

# Cria o diretório /home/apps se não existir
sudo mkdir -p /home/apps

# Cria o arquivo obsidian.sh em /home/apps
echo '#!/bin/sh' | sudo tee /home/apps/obsidian.sh
echo 'docker start obsidian-alpine-container' | sudo tee -a /home/apps/obsidian.sh

# Torna o script obsidian.sh executável
sudo chmod +x /home/apps/obsidian.sh

# Cria um link simbólico para o script em /usr/local/bin
sudo ln -s /home/apps/obsidian.sh /usr/local/bin/obsidian

echo "O script obsidian.sh foi criado em /home/apps e um link simbólico foi criado em /usr/local/bin"
