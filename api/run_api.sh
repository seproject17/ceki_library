#!/bin/bash

file=tmp/pids/server.pid

if [ -e "$file" ]
then
    rm "$file"
    echo "Server PID deleted"
else
    echo "Server PID not found"
fi

echo "Server starting at 3000..."
bundle exec rails server -p 3000 -b '0.0.0.0'