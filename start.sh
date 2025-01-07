#!/bin/bash

# CPU count is first argument
CPUS=$1
if [ -z "$CPUS" ]; then
  # Default to 1 CPU
  CPUS=1
fi
echo "Using $CPUS CPUs"

docker compose down
docker compose up -d

container_name=$(docker compose ps --format json | jq -r '.Name')

docker exec $container_name make
docker exec -it $container_name make CPUS=$CPUS qemu-nox