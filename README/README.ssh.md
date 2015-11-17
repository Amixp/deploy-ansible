# Create keys

ssh-keygen -t rsa -C "Access key for {{ DEST }} hosts by ssh" -f {{ DEST }}

# Copy public key

cat ~/.ssh/{{ DEST }}.pub | ssh remote_host "mkdir ~/.ssh && cat > ~/.ssh/authorized_keys && chmod 700 ~/.ssh && chmod 600 ~/.ssh/*"

# sudo

## change editor

sudo update-alternatives --config editor

## nopassword for user

sudo visudo
  %ubuntu ALL=(ALL) NOPASSWD: ALL

