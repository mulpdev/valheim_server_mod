#!/usr/bin/bash

INSTALL_DIR=~/valheimserver-mod
BOTH_MOD_INSTALL_DIR=~/mod-packages/both
SERVER_MOD_INSTALL_DIR=~/mod-packages/server

pushd .

# Blow away old install and reinstall base server
rm -rf $INSTALL_DIR
#steamcmd +force_install_dir $INSTALL_DIR +login anonymous +app_update 896660 validate +exit
cp -r ~/downloaded $INSTALL_DIR

# start installing mods
cd $BOTH_MOD_INSTALL_DIR

# Install ValheimPlus first, THEN update BepInEx
# 20220123: 
# - VPlus BepInEx Preferred version: 5.4.900
# - Current BepInEx version: 5.4.1700
# - Install BepInEx, HookGenPatcher, Jotunn, BoneAppetit, ValheiimPlus 
#   in order in to avoid inccompatible version error 

unzip UnixServer.zip  -d $INSTALL_DIR

unzip denikson-BepInExPack_Valheim-5.4.1700.zip
rsync -rv BepInExPack_Valheim/ $INSTALL_DIR
chmod u+x $INSTALL_DIR/start_server_bepinex.sh
cp -f ~/works20220123/start_server_bepinex.sh $INSTALL_DIR
rm -rf  BepInExPack_Valheim/ icon.png  manifest.json README.md

# BoneAppetit reqs Jotunn
# Jotunn reqs HookGenPatcher
unzip ValheimModding-HookGenPatcher-0.0.3.zip
mv patchers/BepInEx.MonoMod.HookGenPatcher/ $INSTALL_DIR/BepInEx/patchers/
mv config/HookGenPatcher.cfg $INSTALL_DIR/BepInEx/config/
rm -rf config/ icon.png  manifest.json  patchers/ README.md

unzip ValheimModding-Jotunn-2.4.8.zip
mv plugins/Jotunn.dll $INSTALL_DIR/BepInEx/plugins/
rm -r  icon.png manifest.json README.md plugins/

unzip RockerKitten-BoneAppetit-3.0.4.zip
mv plugins/BoneAppetit.dll $INSTALL_DIR/BepInEx/plugins/
rm -r  icon.png manifest.json README.md plugins/

# No deps or just BepInEx
unzip sweetgiorni-AnyPortal-1.0.4.zip
mv AnyPortal.dll $INSTALL_DIR/BepInEx/plugins/
rm -rf icon.png manifest.json README.md

unzip OdinPlus-Heightmap_Unlimited_Remake-1.3.3.zip
mv plugins/HeightmapUnlimited.dll $INSTALL_DIR/BepInEx/plugins/
rm -rf icon.png  manifest.json README.md plugins/

# Server side ONLY mods.
cd $SERVER_MOD_INSTALL_DIR

unzip DiscordNotifier.zip
mv DiscordNotifier/ $INSTALL_DIR/BepInEx/plugins/
rm -rf icon.png manifest.json README.md

unzip ValheimWebMap.zip
mv WebMap/ $INSTALL_DIR/BepInEx/plugins/
rm -rf icon.png  manifest.json README.md


# Fixup scripts
popd
cp valmod-start.sh $INSTALL_DIR
mv $INSTALL_DIR/start_server_bepinex.sh $INSTALL_DIR/start_server_bepinex.sh.vanilla
cp start_server_bepinex.sh.valheimplus $INSTALL_DIR/start_server_bepinex.sh

echo ""
echo "Run server once to generate configs, then run"
echo "rsync -rv ./BepInEx $INSTALL_DIR"
