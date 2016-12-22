# #########
# Config
# #########

export ANSIBLE_CONFIG=ansible-ivakin.cfg

## Initial host config

ansible-playbook site-node-initial.yml -u root --ask-pass
ansible-playbook site-node-common.yml
ansible-playbook site-node-app.yml


## Deploy

ansible-playbook deploy_html_app_with_nginx.yml --extra-vars \
  "hostname=ivakin_ruvds \
  server_name=inplaw.ru \
  app_dir=ivakin_inp \
  cloud_name=ruvds \
  deploy_user_name=inp \
  src_path=/Users/misha/projects/ivakin/inp/web/public"


## Update

ansible-playbook update_html_app.yml --extra-vars \
  "hostname=ivakin_ruvds \
  deploy_user_name=inp \
  src_path=/Users/misha/projects/ivakin/inp/web/public"


## Barcode Ext Proxy

Ubuntu 16.04, Nginx

sudo systemctl status nginx
sudo systemctl restart nginx
sudo systemctl disable nginx
sudo systemctl enable nginx



