ansible all -m ping

# Check facts

ansible host_name -m setup

# SHA256
openssl dgst -sha256 filename.ext

# Create deploy key
ssh-keygen -t rsa -C "comment" -f deploy_key

# Tar
## Create
tar czf src.tgz reactor_v5

## Extract
tar xzf src.tgz

# Add repository key

sudo apt-key adv --keyserver-options http-proxy=http://localhost:3128/ --keyserver keyserver.ubuntu.com --recv-keys A1715D88E1DF1F24

# Add sudo user

ansible-playbook site.yml -u root --ask-pass

# #########
# Config
# #########
export ANSIBLE_CONFIG=ansible-vagrant.cfg

## Consul
ansible-playbook site-node-consul-agents.yml -l docker-builder --tags "install_app" -vv


# Disable services
ansible MyNodes -a "service webmin stop" --sudo
ansible MyNodes -a "update-rc.d webmin disable" --sudo

## Dev Server
### Registrator
ansible-playbook deploy-docker.yml -l dev \
  --tags "install_app" -vv --extra-vars \
  "app_name=registrator srv_name=registrator \
  docker_image=registrator:latest"

### Zookeeper
ansible-playbook deploy-docker.yml -l dev -vv --extra-vars \
  "app_name=zookeeper srv_name=zookeeper \
  docker_image=zookeeper:3.4.6"

### Kafka
ansible-playbook deploy-docker.yml -l dev -vv --extra-vars \
  "app_name=kafka srv_name=kafka \
  docker_image=kafka:0.9.0.0"

### Redis

#### barcode-mobile
ansible-playbook deploy-docker.yml -l dev -vv --extra-vars \
  "app_name=redis srv_name=redis-barcode-mobile \
  docker_image=redis:3.0.6"

## Config nodes
ansible-playbook site-node-initial.yml -l kafka-nodes --ask-pass
ansible-playbook site.yml

ansible-playbook site-node-initial.yml -l barcode_1s --ask-pass
ansible-playbook site.yml -l barcode_1s

<!-- ansible-playbook site-node-initial.yml -l barcode_1s --ask-pass -->
ansible-playbook site.yml -l docker-builder


<!-- ansible-playbook config_node_vagrant.yml --extra-vars \
  "graphite_host=stat.name.com graphite_path_prefix=name.service.version"
 -->


# #########
# Keys
# #########
_apps/
  backgroundjobs/keys/*
  lb/keys/*
  lb_chat/keys/*


## Setup AWS keys
cp .aws-keys-empty .aws-key

# #########
# Single Prod - Prod on One Single Server
# #########

## Setup env
source .aws-keys
export ANSIBLE_CONFIG=ansible-singleprod.cfg

## Deploy

### service 1
ansible-playbook deploy_ruby_app.yml --extra-vars "key1=value1 key2=value2"

# Update

### service 1
ansible-playbook update_ruby_app.yml --extra-vars "key1=value1 key2=value2"


# #########
# Prod
# #########

## Setup AWS keys
cp .aws-keys-empty .aws-keys

## Setup env
source .aws-keys
export ANSIBLE_CONFIG=ansible-aws.cfg

## Create node
ansible-playbook -v create_node_service_aws.yml --extra-vars \
  "access_key=A secret_key=r"

### Load Balancer

#### Create
ansible-playbook create_node_lb_aws.yml --extra-vars \
  "image_name= \
  instance_type_name=c3.large \
  tag_Name="

#### Update balancing ip-addresses
ansible-playbook update_lb_aws.yml --extra-vars \
  '{"service_archive":[["v2","3100"],["v3","3101"],["v4","3102"],["v5","3103"],["v6","3105"]],
    "service_versions":[["v7","v7_0_2"]]}'

## Create

#### Create
ansible-playbook create_node_service_aws.yml --extra-vars \
  "image_name= \
  instance_type_name=c3.large \
  tag_Name= \
  version= \
  count="

## Deploy

## deploy service 1
ansible-playbook deploy_ruby_app_with_nginx.yml --extra-vars \
  "cloud_name= \
   deploy_user_name= \
   ruby_version=ruby \
   git_repo_from=github.com \
   git_repo_name= \
   app_env=production \
   app_version=master \
   tag_Name="

## Update

### service 1
ansible-playbook update_ruby_app.yml --extra-vars \
  "deploy_user_name=\
   app_name= \
   git_repo_name= \
   app_version=master \
   tag_Name="


# #########
# Prod Load-Test
# #########
export ANSIBLE_CONFIG=ansible-load-aws.cfg

ansible-playbook config_node_aws_lb.yml

## Create node Yandex.Tank
ansible-playbook create_node_tank_aws.yml --extra-vars \
  "image_name= \
   instance_type_name=c3.large \
   tag_Name=Yandex.Tank"

## Rename Tags
ansible-playbook update_tags_aws.yml --extra-vars \
  "region=us-west-2 \
   tag_from= \
   tag_to="

## ec2.py
ansible -i ec2.py -u ubuntu security_group_service_1 -m ping
