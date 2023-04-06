#!/bin/bash

echo "* Adjust Docker to share metrics ..."
echo '
{
  "metrics-addr" : "192.168.69.202:9323",
  "experimental" : true
}' >> /etc/docker/daemon.json
systemctl restart docker
