# #########
# Config
# #########
export ANSIBLE_CONFIG=ansible-{{ NAME }}.cfg

# Firewall

sudo ufw allow {{ SSH_PORT }}/tcp
sudo ufw limit {{ SSH_PORT }}/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp

## Test and Enable

sudo ufw show added
sudo ufw enable

# Create a Swap File

sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

## Add to fstab file

sudo sh -c 'echo "/swapfile none swap sw 0 0" >> /etc/fstab'

