#!/bin/bash

export templdpath=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=./linux64:$LD_LIBRARY_PATH
export SteamAppId=892970


echo "Starting server PRESS CTRL-C to exit"

# Tip: Make a local copy of this script to avoid it being overwritten by steam.
# NOTE: Minimum password length is 5 characters & Password cant be in the server name.
# NOTE: You need to make sure the ports 2456-2458 is being forwarded to your server through your local router & firewall.
#./valheim_server.x86_64 -name "My server" -port 2456 -world "Dedicated" -password "secret"
#./start_server_bepinex.sh  -name "Phasmophobia2" -port 9666 -world "Modheim" -password "GiveUsASign" -public 1

./start_server_bepinex.sh  -nographics -batchmode  -name $VALMOD_NAME -port $VALMOD_PORT -world $VALMOD_WORLD -password $VALMOD_PASS -public $VALMOD_PUBLIC

#> "logs/valmod_"`date "+%Y%m%d-%H%M"`".log" 2>&1

export LD_LIBRARY_PATH=$templdpath


