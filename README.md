# BetterMC 1.16.5 Docker

## Building

1. Clone the repo
2. Run `docker build --tag bettermc-docker:latest bettermc-docker`

## Running the server

```
docker run -d \
    -p 25565:25565
    -e OP=your_MC_username \
    --name=tekkit-server \
    --restart=unless-stopped \
    tekkit-legends:latest
```

ENV vars:
- OP
- MEMORY_MAX
  - Default: `-Xmx3G`
- MEMORY_MIN
  - Default: `-Xms2G`
- MC_VERSION
  - Default: `1.16.5`
- FORGE_VERSION
  - Default: `36.2.35`

## Docker-Compose example

```yml
version: 3.7
services:
    bettermc:
        build: path_to_repo/.
        container_name: bettermc
        restart: unless-stopped
        # network_mode: host
        ports:
            - 25565:25565
        volumes:
            - /path/to/desired/folder/world:/minecraft/world
            - /path/to/desired/folder/world_nether:/minecraft/world_nether
            - /path/to/desired/folder/world_the_end:/minecraft/world_the_end
        environment:
            OP=your_mc_name
```
