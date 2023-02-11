FROM ttbb/telegraf:nake

COPY docker-build /opt/telegraf/mate

WORKDIR /opt/telegraf

CMD ["/usr/bin/dumb-init", "bash", "-vx", "/opt/telegraf/mate/scripts/start.sh"]
