#!/bin/bash

set -x

mysql -h"$MYSQL_HOST" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD"

for i in {30..0}; do
  if echo 'SELECT 1' | mysql -h"$MYSQL_HOST" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" &> /dev/null; then
  	break
  fi
  echo 'MySQL init process in progress...'
  sleep 1
done

echo "$0: running /sql_scripts/schema.sql"; mysql -h"$MYSQL_HOST" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE" < /sql_scripts/schema.sql; echo;

echo "$0: running /sql_scripts/data.sql"; mysql -h"$MYSQL_HOST" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE" < /sql_scripts/data.sql; echo;
