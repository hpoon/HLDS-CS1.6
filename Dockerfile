FROM kriansa/cs-16:latest

# Runtime settings
ENV RCON_PASSWORD=""
ENV SV_PASSWORD=""
ENV MAXPLAYERS="24"
ENV MAPNAME="de_dust2"

# Copy the files
COPY --chown=steam:steam cstrike/maps cstrike_downloads/maps
COPY --chown=steam:steam cstrike/addons cstrike/addons
COPY --chown=steam:steam cstrike/cfgs cstrike/cfgs
COPY --chown=steam:steam cstrike/liblist.gam cstrike/mapcycle.txt \
  cstrike/server.cfg cstrike/motd.html cstrike/
