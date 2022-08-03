FROM openjdk:8-alpine

ENV MEMORY_MAX="-Xmx3G"
ENV MEMORY_MIN="-Xms2G"
ENV MC_VERSION="1.16.5"
ENV FORGE_VERSION="36.2.35"
ENV OP=""

RUN apk add bash
RUN apk add unzip
RUN apk add wget

# Setup BetterMC server files
RUN mkdir /minecraft
RUN wget -O /tmp/minecraft.zip https://mediafiles.forgecdn.net/files/3871/784/Better+MC+Server+Pack+%5bFORGE%5d+v57.5.zip
RUN unzip /tmp/minecraft.zip -d /minecraft
RUN RUN mv /minecraft/Better\ MC\ Server\ Pack\ \[FORGE\]\ $MC_VERSION/* /minecraft

COPY ./entry.sh /minecraft/entry.sh
RUN chmod 755 /minecraft/entry.sh

VOLUME /minecraft
EXPOSE 25565

WORKDIR /minecraft
ENTRYPOINT ["/minecraft/entry.sh"]