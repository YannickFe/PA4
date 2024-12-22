#!/bin/bash
docker compose up -d

container_name=$(docker compose ps --format json | jq -r '.Name')

docker exec $container_name make
docker exec -it $container_name make qemu-nox