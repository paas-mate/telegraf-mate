FROM ttbb/compile:rust AS build
COPY . /opt/sh/compile
WORKDIR /opt/sh/compile
RUN /root/.cargo/bin/cargo build


FROM ttbb/telegraf:nake

COPY docker-build /opt/sh/telegraf/mate

COPY --from=build /opt/sh/compile/target/debug/telegraf-mate-rust /opt/sh/telegraf/mate/telegraf-mate

WORKDIR /opt/sh/telegraf

CMD ["/usr/bin/dumb-init", "bash", "-vx", "/opt/sh/telegraf/mate/scripts/start.sh"]
