#!/bin/bash -xe



exec > >(tee /var/log/cloud-init-output.log|logger -t user-data -s 2>/dev/console) 2>&1

yum install jq -y

REGION=$(/usr/bin/curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone | sed 's/[a-z]$//')

EFS_ID=$(aws efs describe-file-systems --query 'FileSystems[?Name==`ghost_content`].FileSystemId' --region $REGION --output text)

SSM_DB_PASSWORD="/ghost/dbpassw"
# REGION=$(/usr/bin/curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone | sed 's/[a-z]$//')
DB_PASSWORD=$(aws ssm get-parameter --name $SSM_DB_PASSWORD --query Parameter.Value --with-decryption --region $REGION --output text)
DB_URL=$(aws rds describe-db-instances --region $REGION --query 'DBInstances[*].[Endpoint.Address]' --output text)

DB_NAME='ghost'
DB_USER='foo'

### Update this to match your ALB DNS name
LB=ghost-alb
# LB_DNS_NAME=ghost-alb-392455338.us-east-1.elb.amazonaws.com
LB_DNS_NAME=$(aws elbv2 describe-load-balancers --region $REGION --names $LB | jq -r '.LoadBalancers[].DNSName')
###


### Install pre-reqs

curl -sL https://rpm.nodesource.com/setup_14.x | sudo bash -

yum install -y nodejs amazon-efs-utils jq

npm install ghost-cli@latest -g



adduser node

usermod -aG wheel node

cd /home/node/



sudo -u node ghost install local



### EFS mount

mkdir -p /home/node/ghost/content

mount -t efs -o tls $EFS_ID:/ /home/node/ghost/content


chown -R node:node ghost/
IS_CONTENT_EMPTY=$(ls -A /home/node/ghost/content)
if [[ -z $IS_CONTENT_EMPTY ]]; then 

  echo 'Empty EFS. Copying content...'
  sudo -u node cp -R ./content/* /home/node/ghost/content
  
else 
  echo 'EFS OK. Skipping'
fi

sudo -u ghost_user cp -R ./content/* /home/ghost_user/ghost/content

chmod -R ga+w ghost/

cat << EOF > config.development.json

{
  "url": "http://${LB_DNS_NAME}",
  "server": {
    "port": 2368,
    "host": "0.0.0.0"
  },
  "database": {
    "client": "mysql",
    "connection": {
        "host": "${DB_URL}",
        "port": 3306,
        "user": "${DB_USER}",
        "password": "$DB_PASSWORD",
        "database": "${DB_NAME}"
    }
  },
  "mail": {
    "transport": "Direct"
  },
  "logging": {
    "transports": [
      "file",
      "stdout"
    ]
  },
  "process": "local",
  "paths": {
    "contentPath": "/home/node/ghost/content"
  }
}


EOF



sudo -u node ghost stop

sudo -u node ghost start

