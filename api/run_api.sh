#!/bin/bash

file=tmp/pids/server.pid
uploads_dir=public/uploads

if [ -e "$file" ]
then
    rm "$file"
    echo "Server PID deleted"
else
    echo "Server PID not found"
fi

# Нужно установить переменную окружения
# Удалять при каждом запуске папку или нет

if [ -e "$uploads_dir" ]
then
    rm -rf "$uploads_dir"
    echo "Uploads dir cleaned"
fi

mkdir -p "$uploads_dir"
mkdir -p "$uploads_dir/books"
mkdir -p "$uploads_dir/users"

echo "Uploads dir created"

echo "Server starting at 3000..."
bundle exec rails server -p 3000 -b '0.0.0.0'