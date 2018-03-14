#!/bin/sh

#create sql_scripts directory
mkdir -p sql_scripts
#copy the SQL files to the current directory
cp ../src/main/resources/db/mysql/schema.sql ./sql_scripts/schema.sql
cp ../src/main/resources/db/mysql/data.sql ./sql_scripts/data.sql

echo "Starting the build..."
docker build -t petclinic-db-init:latest .
