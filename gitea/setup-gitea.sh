#!/bin/bash

# Start Gitea
docker compose -f /vagrant/gitea/docker-compose.yml up -d

# Wait until ready
while true; do 
  echo 'Trying to connect to http://192.168.69.202:3000 ...'; 
  if [ $(curl -s -o /dev/null -w "%{http_code}" http://192.168.69.202:3000) == "200" ]; then 
    echo '... connected.'; 
    break; 
  else 
    echo '... no success. Sleep for 5s and retry.'; 
    sleep 5; 
  fi 
done

# Add user
docker container exec -u 1000 gitea gitea admin user create --username vagrant --password vagrant --email vagrant@containers.do1.exam

# Clone the project
git clone https://github.com/shekeriev/fun-facts /tmp/exam

# Add it to Gitea (but as public repository)
cd /tmp/exam && git push -o repo.private=false http://vagrant:vagrant@192.168.69.202:3000/vagrant/exam

# Add a Webhook
curl -X 'POST' 'http://192.168.69.202:3000/api/v1/repos/vagrant/exam/hooks' \
  -H 'accept: application/json' \
  -H 'authorization: Basic '$(echo -n 'vagrant:vagrant' | base64) \
  -H 'Content-Type: application/json' \
  -d '{
  "active": true,
  "branch_filter": "*",
  "config": {
    "content_type": "json",
    "url": "http://192.168.69.203:8080/gitea-webhook/post",
    "http_method": "post"
  },
  "events": [
    "push"
  ],
  "type": "gitea"
}'
