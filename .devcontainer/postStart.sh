#!/bin/bash

# Fix to make Docker deamon start after a Codespace
# has been shutdown.
if (! curl -s --unix-socket /var/run/docker.sock http/_ping 2>&1 >/dev/null)
then
  DOCKER_NETWORKS='/var/lib/docker/network'
  if sudo bash -c "[[ -d ${DOCKER_NETWORKS} ]]"
  then
    echo 'Cleaning up Docker networks'
    sudo rm -rf ${DOCKER_NETWORKS}
  fi
    
  # Clean up the Docker PID file
  DOCKER_PID='/var/run/docker.pid'
  if [[ -f ${DOCKER_PID} ]]
  then
    sudo rm -f ${DOCKER_PID}
  fi

  # Start Docker Daemon
  sudo service docker start

  # Wait for Docker Deamon
  until (curl -s --unix-socket /var/run/docker.sock http/_ping 2>&1 >/dev/null)
  do
    echo "Waiting for docker to start..." 
    sleep 1
  done
fi

# Clean up containers
docker rm -f $(docker ps -a -q)

# Clean up docker containers and bring up development containers
docker-compose up -d

