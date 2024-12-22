#!/bin/bash
docker compose up -d
docker exec xv6-container make
docker exec -it xv6-container make qemu-nox