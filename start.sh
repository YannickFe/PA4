#!/bin/bash
docker compose up -d --build
docker exec ubuntu make
docker exec -it ubuntu make qemu-nox