# Gravitee API management setup

Gravitee is an open source API management platform.

## Installation

Docker compose option.
- [docker compose quick install](https://documentation.gravitee.io/apim/install-and-upgrade/docker/quick-install)
- [docker compose custom install with custom persistency](https://documentation.gravitee.io/apim/install-and-upgrade/docker/docker-compose)
- [source for docker compose file](https://raw.githubusercontent.com/gravitee-io/gravitee-docker/master/apim/4.x/docker-compose.yml)

Get compose file and run

    docker compose -f docker-compose-apim.yml up -d
    # management ui
    http://localhost:8084
    # developer portal
    http://localhost:8085/
    # deployed apis
    http://localhost:8082/

### Installation with custom persistence

Recommended project structure (above links) for mapping data volumes

    /gravitee
    ├── apim-gateway
    │    ├── logs
    │    └── plugins
    ├── apim-management-api
    │    ├── logs
    │    └── plugins
    ├── apim-management-ui
    │    └── logs
    ├── apim-portal-ui
    │    └── logs
    ├── elasticsearch
    │    └── data
    └── mongodb
        └── data
