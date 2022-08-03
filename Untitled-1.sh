#!/bin/bash

MINECRAFT="1.16.5"
FORGE="36.2.35"
ARGS=""
OTHERARGS="-Dlog4j2.formatMsgNoLookups=true"
EULA="eula=true"
OP=""

if [[ ! -s "forge.jar" ]];then
    echo "Forge Server JAR-file not found. Downloading installer...";
    wget -O forge-installer.jar https://files.minecraftforge.net/maven/net/minecraftforge/forge/$MINECRAFT-$FORGE/forge-$MINECRAFT-$FORGE-installer.jar;
    
    if [[ -s "forge-installer.jar" ]]; then
        
        echo "Installer downloaded. Installing...";
        $JAVA -jar forge-installer.jar --installServer;
        mv forge-$MINECRAFT-$FORGE.jar forge.jar;
        
        if [[ -s "forge.jar" ]];then
            rm -f forge-installer.jar;
            echo "Installation complete. forge-installer.jar deleted.";
        fi
        
    else
        echo "forge-installer.jar not found. Maybe the Forge servers are having trouble.";
        echo "Please try again in a couple of minutes.";
    fi
else
    echo "forge.jar present. Moving on..."
fi

if [[ ! -s "minecraft_server.$MINECRAFT.jar" ]];then
  echo "Minecraft Server JAR-file not found. Downloading...";
  wget -O minecraft_server.$MINECRAFT.jar Optional[https://launcher.mojang.com/v1/objects/1b557e7b033b583cd9f66746b7a9ab1ec1673ced/server.jar];
else
  echo "minecraft_server.$MINECRAFT.jar present. Moving on..."
fi

if [[ ! -s "eula.txt" ]]; then
    echo "Accepting EULA 4 U :)"
    echo $EULA > eula.txt
    echo "Also adding $OP as 1st server OP"
    echo $OP > ops.txt
else
    echo "EULA exists, default OP added already"
fi

echo "Starting server...";
echo "Minecraft version: $MINECRAFT";
echo "Forge version: $FORGE";
echo "Java version:"
$JAVA -version
echo "Java args: $ARGS";

java $OTHERARGS $ARGS -jar forge.jar nogui