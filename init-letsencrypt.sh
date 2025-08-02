#!/bin/bash

set -e
source .env

if ! [ -x "$(command -v docker-compose)" ]; then
  echo 'Error: docker-compose is not installed.' >&2
  exit 1
fi

mkdir -p certbot/www certbot/conf

docker-compose up -d nginx

sleep 5

docker-compose run --rm certbot certonly --webroot \
  --webroot-path=/var/www/certbot \
  --email $EMAIL \
  --agree-tos \
  --no-eff-email \
  -d $DOMAIN -d www.$DOMAIN

docker-compose down
docker-compose up -d
