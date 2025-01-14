#!/bin/bash

# CPU count is first argument
CPUS=$1
if [ -z "$CPUS" ]; then
  # Default to 1 CPU
  CPUS=1
fi
echo "Using $CPUS CPUs"

docker compose up -d

container_name=$(docker compose ps --format json | jq -r '.Name')
echo "Container name: $container_name"

docker exec $container_name make

# function to handle cleanup on exit
cleanup() {
  echo "cleanup - Stopping Docker container..."
  docker compose down
  exit 0
}

# trap SIGINT, SIGTERM, and EXIT signals and call cleanup
trap cleanup SIGINT SIGTERM EXIT

# create a named pipe to pass input to QEMU
# since passing tty using docker exec -t option
# wont allow us to catch SIGINT etc.
# wee need to catch it since we cant exit otherwise
PIPE=$(mktemp -u)
mkfifo $PIPE

# run QEMU in the container with input from the named pipe
cat $PIPE | docker exec -i $container_name make CPUS=$CPUS qemu-nox &

# pass input to the named pipe
while true; do
  read -r input
  echo "$input" > $PIPE
done

# wait for QEMU process to finish
wait $!

# call cleanup on exit
cleanup