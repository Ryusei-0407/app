#!/bin/bash

set -x
set -eo pipefail

if ! [ -x "$(command -v sqlx)" ]; then
    echo >&2 "Error: sqlx is not installed."
    echo >&2 "Use:"
    echo >&2 "      cargo install sqlx-cli --features postgres"
    echo >&2 "to install it."
    exit 1
fi

DB_USER=${POSTGRES_USER:=postgres}
DB_PASSWORD="${POSTGRES_PASSWORD:=password}"
DB_NAME="${POSTGRES_DB:=newsletter}"
DB_PORT="${POSTGRES_POST:=5432}"

if [[ -z "${SKIP_DOCKER}" ]]
then
    docker-compose up -d --build
fi

echo >&2 "Postgres is up and running on port ${DB_PORT} - running migrations now!"

export $(cat .env | xargs)
sqlx database create
sqlx migrate run

echo >&2 "Postgres has been migrated."
