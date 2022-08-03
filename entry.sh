#!/bin/bash

MINECRAFT=$MC_VERSION
FORGE=$FORGE_VERSION
MEMORY_MIN=$MEMORY_MIN
MEMORY_MAX=$MEMORY_MAX
OTHERARGS="-Dlog4j2.formatMsgNoLookups=true"
EULA="eula=true"
OP=$OP

if [[ ! -s "forge.jar" ]];then
    echo "Downloading forge...";
    wget -O forge-installer.jar https://files.minecraftforge.net/maven/net/minecraftforge/forge/$MINECRAFT-$FORGE/forge-$MINECRAFT-$FORGE-installer.jar;
    
    if [[ -s "forge-installer.jar" ]]; then
        
        echo "Installing forge...";
        java -jar forge-installer.jar --installServer;
        mv forge-$MINECRAFT-$FORGE.jar forge.jar;
        
        if [[ -s "forge.jar" ]];then
            rm -f forge-installer.jar;
            echo "Finished!";
        fi
        
    else
        echo "forge-installer.jar not found. Forge servers are probably down...";
    fi
else
    echo "Forge Exists"
fi

if [[ ! -s "minecraft_server.$MINECRAFT.jar" ]];then
  echo "Downloading Minecraft server...";
  wget -O minecraft_server.$MINECRAFT.jar Optional[https://launcher.mojang.com/v1/objects/1b557e7b033b583cd9f66746b7a9ab1ec1673ced/server.jar];
else
  echo "Minecraft Exists"
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
echo "Java args: $OTHERARGS, $MEMORY_MAX, $MEMORY_MIN";

java $OTHERARGS $MEMORY_MAX $MEMORY_MIN -jar forge.jar nogui