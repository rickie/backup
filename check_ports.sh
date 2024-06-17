#!/bin/bash

# Define an array of ports to check and kill processes
ports=(5432 27017 15672 8200)

for port in "${ports[@]}"
do
  echo "Checking port $port..."
  # Find the PID of the process listening on the port
  pid=$(sudo lsof -i -P -n | grep ":$port" | awk '{print $2}')
  
  # Check if a PID was found
  if [ -n "$pid" ]; then
    echo "Killing process $pid on port $port"
    sudo kill $pid
  else
    echo "No process found on port $port"
  fi
done

echo "Done."
