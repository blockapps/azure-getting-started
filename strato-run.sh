#!/usr/bin/env bash

# Optional arguments:
# `-stop` - stop STRATO containers
# `-wipe` - stop STRATO containers and wipe out volumes

set -e

registry="repo.blockapps.net:5000"

function wipe {
    echo "Stopping STRATO containers"
    docker-compose -f docker-compose.latest.yml -p strato kill 2> /dev/null || docker-compose -f docker-compose.release.yml -p strato kill
    docker-compose -f docker-compose.latest.yml -p strato down -v 2> /dev/null || docker-compose -f docker-compose.release.yml -p strato down -v
}

function stop {
    echo "Stopping STRATO containers"
    docker-compose -f docker-compose.latest.yml -p strato kill 2> /dev/null || docker-compose -f docker-compose.release.yml -p strato kill
    docker-compose -f docker-compose.latest.yml -p strato down 2> /dev/null || docker-compose -f docker-compose.release.yml -p strato down
}

case $1 in
 "-stop")
     echo "Stopping STRATO containers"
     stop
     exit 0
     ;;
 "-wipe")
     echo "Stopping STRATO containers and wiping out volumes"
     wipe
     exit 0
     ;;
   *)
     ;;
 esac

echo "
    ____  __           __   ___
   / __ )/ /___  _____/ /__/   |  ____  ____  _____
  / __  / / __ \/ ___/ //_/ /| | / __ \/ __ \/ ___/
 / /_/ / / /_/ / /__/ ,< / ___ |/ /_/ / /_/ (__  )
/_____/_/\____/\___/_/|_/_/  |_/ .___/ .___/____/
                              /_/   /_/
"

if ! docker ps &> /dev/null
then
    echo 'Error: docker is required to be installed and configured for non-root users: https://www.docker.com/'
    exit 1
fi

if ! docker-compose -v &> /dev/null
then
    echo 'Error: docker-compose is required: https://docs.docker.com/compose/install/'
    exit 2
fi

if grep -q "${registry}" ~/.docker/config.json
then
    export genesisBlock=$(< gb.json)
    export NODE_NAME=${1:-localhost}
    export BLOC_URL=http://${1:-localhost}/bloc/v2.1
    export BLOC_DOC_URL=http://${1:-localhost}/docs/?url=/bloc/v2.1/swagger.json
    export STRATO_URL=http://${1:-localhost}/strato-api/eth/v1.2
    export STRATO_DOC_URL=http://${1:-localhost}/docs/?url=/strato-api/eth/v1.2/swagger.json
    export CIRRUS_URL=http://${1:-localhost}/cirrus/search
    export cirrusurl=nginx/cirrus
    export stratoHost=nginx
    export ssl=false
    docker-compose -f docker-compose.release.yml -p strato up -d
else
    echo "Please reach out to the BlockApps team at: info@blockapps.net"
    exit 3
fi