#!/bin/sh

echo "Starting mongo"
/usr/bin/mongod -f /etc/mongod.conf &

echo "Starting acquisition"

cd /etc/nsa/
./startup.sh all
