FROM kriansa/cs-16:latest

USER root
RUN echo "deb http://archive.debian.org/debian buster main contrib non-free" > /etc/apt/sources.list && \
    echo "deb http://archive.debian.org/debian-security buster/updates main contrib non-free" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y --allow-unauthenticated curl strace && \
    rm -rf /var/lib/apt/lists/*
USER steam

# Runtime settings
ENV MAXPLAYERS="24"
ENV MAPNAME="de_dust2"

# Copy the files
COPY --chown=steam:steam cstrike/addons cstrike/addons
COPY --chown=steam:steam cstrike/cfgs cstrike/cfgs
COPY --chown=steam:steam cstrike/liblist.gam cstrike/mapcycle.txt \
  cstrike/*.cfg cstrike/motd.html cstrike/

# Copy the maps/textures/etc.
COPY --chown=steam:steam cstrike/maps cstrike_downloads/maps
COPY --chown=steam:steam cstrike/gfx cstrike_downloads/gfx
COPY --chown=steam:steam cstrike/*.wad cstrike_downloads/
COPY --chown=steam:steam cstrike/models cstrike_downloads/models
COPY --chown=steam:steam cstrike/sound cstrike_downloads/sound
COPY --chown=steam:steam cstrike/sprites cstrike_downloads/sprites

CMD /home/steam/hlds/hlds_run -game cstrike +ip 0.0.0.0 +maxplayers $MAXPLAYERS +map $MAPNAME
