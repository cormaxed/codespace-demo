#!/bin/sh

# Setup a private npm registry. 
# Replace @registryname and add your authtoken to Codespace secrets.
#echo "@registryname:registry=https://npm.pkg.github.com/" >> ~/.npmrc
#echo "//npm.pkg.github.com/:_authToken=${NODE_AUTH_TOKEN}" >> ~/.npmrc

# Start Docker Daemon
sudo service docker start

# Wait for Docker Deamon
until (curl -s --unix-socket /var/run/docker.sock http/_ping 2>&1 >/dev/null)
do
  echo "Waiting for docker to start..." 
  sleep 1
done
