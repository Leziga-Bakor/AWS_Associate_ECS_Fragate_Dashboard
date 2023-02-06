#!/bin/bash -xe



exec > >(tee /var/log/cloud-init-output.log|logger -t user-data -s 2>/dev/console) 2>&1

yum install jq -y

REGION=$(/usr/bin/curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone | sed 's/[a-z]$//')

EFS_ID=$(aws efs describe-file-systems --query 'FileSystems[?Name==`ghost_content`].FileSystemId' --region $REGION --output text)


### Update this to match your ALB DNS name
LB=ghost-alb
# LB_DNS_NAME=ghost-alb-392455338.us-east-1.elb.amazonaws.com
LB_DNS_NAME=$(aws elbv2 describe-load-balancers --region $REGION --names $LB | jq -r '.LoadBalancers[].DNSName')
###


### Install pre-reqs

curl -sL https://rpm.nodesource.com/setup_14.x | sudo bash -

yum install -y nodejs amazon-efs-utils

npm install ghost-cli@1.21.0 -g



adduser ghost_user

usermod -aG wheel ghost_user

cd /home/ghost_user/



sudo -u ghost_user ghost install local



### EFS mount

mkdir -p /home/ghost_user/ghost/content

mount -t efs -o tls $EFS_ID:/ /home/ghost_user/ghost/content



if [ -z "$(ls -A /home/ghost_user/ghost/content)" ]; then

  chown -R ghost_user:ghost_user ghost/
  sudo -u ghost_user cp -R ./content/* /home/ghost_user/ghost/content

fi

##################################################################################
# FILE=/home/ghost_user/ghost/content/data/ghost-local.db

# if [ -f "$FILE" ]; then

#   echo "$FILE exists."

# else

#   echo "$FILE not exist. Copying"

#   mkdir -p /home/ghost_user/ghost/content/data

#   mv "/home/ghost_user/content/data/ghost-local.db" "/home/ghost_user/ghost/content/data"

# fi



chmod -R 777 /home/ghost_user/ghost



cat << EOF > config.development.json



{

  "url": "http://${LB_DNS_NAME}",

  "server": {

    "port": 2368,

    "host": "0.0.0.0"

  },

  "database": {

    "client": "sqlite3",

    "connection": {

      "filename": "/home/ghost_user/content/data/ghost-local.db"

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

    "contentPath": "/home/ghost_user/ghost/content"

  }

}

EOF



sudo -u ghost_user ghost stop

sudo -u ghost_user ghost start

