# CS 1.6 Dedicated Server

This is a HLDS setup I made for CS with custom addons and an easy ramp-up. It
also fixes several installation issues most people have when trying to create a
dedicated CS server.

## What's in it?

* Custom maps
* Metamod (1.21.1-am)
* AMX Mod X (1.8.2)
* Podbot (V3B22)

Custom AMX plugins:

* HPK (High Ping Kicker)
* Podbot menu
* Round Money
* Rock the vote
* Admin all in one

## Quick Reference (docker-compose)

Fill in the path to the users.ini file

```
  hlds:
    image: henrypoon/hlds-cs1.6
    volumes:
      - PATH-TO-USERS.INI:/home/steam/hlds/cstrike/addons/amxmodx/configs/users.ini
      - ./cstrike/addons:/home/steam/hlds/cstrike/addons
      - ./cstrike/logs:/home/steam/hlds/cstrike/logs
      - ./cstrike/cfgs:/home/steam/hlds/cstrike/cfgs:ro
      - ./cstrike/liblist.gam:/home/steam/hlds/cstrike/liblist.gam:ro
      - ./cstrike/mapcycle.txt:/home/steam/hlds/cstrike/mapcycle.txt:ro
      - ./cstrike/server.cfg:/home/steam/hlds/cstrike/server.cfg:ro
      - ./cstrike/motd.html:/home/steam/hlds/cstrike/motd.html:ro
      - ./cstrike/maps:/home/steam/hlds/cstrike_downloads/maps:ro
      - ./cstrike/maps:/home/steam/hlds/cstrike_downloads/gfx:ro
      - ./cstrike/maps:/home/steam/hlds/cstrike_downloads/models:ro
      - ./cstrike/maps:/home/steam/hlds/cstrike_downloads/sound:ro
      - ./cstrike/maps:/home/steam/hlds/cstrike_downloads/sprites:ro
    ports:
      - "27015:27015"
      - "27015:27015/udp"
    environment:
      - RCON_PASSWORD=""
      - SV_PASSWORD=""
      - MAXPLAYERS="24"
      - MAPNAME="de_dust2"
```

Sample users.ini file (replace your steam ID)

```
; Users configuration file
; File location: $moddir/addons/amxmodx/configs/users.ini

; Line starting with ; is a comment

; Access flags:
; a - immunity (can't be kicked/baned/slayed/slaped and affected by other commmands)
; b - reservation (can join on reserved slots)
; c - amx_kick command
; d - amx_ban and amx_unban commands
; e - amx_slay and amx_slap commands
; f - amx_map command
; g - amx_cvar command (not all cvars will be available)
; h - amx_cfg command
; i - amx_chat and other chat commands
; j - amx_vote and other vote commands
; k - access to sv_password cvar (by amx_cvar command)
; l - access to amx_rcon command and rcon_password cvar (by amx_cvar command)
; m - custom level A (for additional plugins)
; n - custom level B
; o - custom level C
; p - custom level D
; q - custom level E
; r - custom level F
; s - custom level G
; t - custom level H
; u - menu access
; z - user (no admin)

; Account flags:
; a - disconnect player on invalid password
; b - clan tag
; c - this is steamid/wonid
; d - this is ip
; e - password is not checked (only name/ip/steamid needed)
; k - name or tag is case sensitive.  eg: if you set it so the name "Ham"
;     is protected and case sensitive (flags "k" only), then anybody
;     can use the names "haM", "HAM", "ham", etc, but not "Ham"

; Password:
; Add to your autoexec.cfg: setinfo _pw "<password>"
; Change _pw to the value of amx_password_field

; Format of admin account:
; <name|ip|steamid> <password> <access flags> <account flags>

; Examples of admin accounts:
; "STEAM_0:0:123456" "" "abcdefghijklmnopqrstu" "ce"
; "123.45.67.89" "" "abcdefghijklmnopqrstu" "de"
; "My Name" "my_password" "abcdefghijklmnopqrstu" "a"

"loopback" "" "abcdefghijklmnopqrstu" "de"
"STEAM-ID-GOES-HERE" "" "abcdefghijklmnopqrstu" "ce"
```

## Setup

1. Install [Docker](https://www.docker.com/)
1. Install [Docker Compose](https://docs.docker.com/compose/install/)
1. Run `$ bin/setup`
1. Now you have to add yourself as an admin. Edit the file
   `cstrike/addons/amxmodx/configs/users.ini` and add your credentials. See the
   examples below:

   ```conf
   ; Examples of admin accounts:
   ; "STEAM_0:0:123456" "" "abcdefghijklmnopqrstu" "ce"
   ; "123.45.67.89" "" "abcdefghijklmnopqrstu" "de"
   ; "My Name" "my_password" "abcdefghijklmnopqrstu" "a"
   ```

1. **On your client**, edit the file `cstrike/userconfig.cfg` and add your
   password there, like the following:

   ```
   setinfo "_pw" "mypa$$w0rd"
   ```

## Running

This way to run the server is deprecated.  You should just use the compose sample above.

To run the server, you can simply run:

`$ bin/server start`

Follow the logs:

`$ bin/server logs -f`

Stop the server:

`$ bin/server stop`

## Configuring

Edit `server.cfg` and files on `cfgs` folder to set different server settings.

Also, configure `AMXModX` as you wish by modifying the files on
`addons/amxmodx`.

There are some settings related to server initialization that are located on
`.env` file. Changes on them will most likely require a restart.

Adding new maps require you to restart the server.

## Common instalation issues

When doing a [clean HLDS
installation](https://developer.valvesoftware.com/wiki/SteamCMD#Linux), as
suggested on Steam manual, a few issues may arise.

1. Installation just doesn't work. Sometimes you would have to run `app_update
   90` several times and it wouldn't install all needed files. This is a hard
   one to solve, and I did it with help of [this
   workaround](https://danielgibbs.co.uk/2013/11/hlds-steamcmd-workaround-appid-90/).
   What it does is basically add 3 manifest files on `hlds/steamapps` folder
   and proceeds the installation.
2. First time you run HLDS, it crashes at the first time. This is some other
   bug caused by a missing `steam_appid.txt` file on `hlds` folder.
3. Warning messages of missing `$HOME/.steam/sdk32/steamclient.so` files. The
   fix is quite easy: we just need to link these files onto the expected path.
4. Warning messages of missing `custom.hpk` file. This can get annoying and
   make us think that there's something wrong. Don't worry, this is just a file
   used to store custom sprays from people who connect to the server. The fix
   for that is creating a blank `cstrike/custom.hpk` file when we start the
   server for the first time.

This Docker image fix all these errors gracefully so you don't have to worry.

## Compatibility

Currently, this server is compatible with MacOS and Linux.

## License

MIT.
