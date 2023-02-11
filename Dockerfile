FROM shoothzj/compile:rust AS build
COPY . /opt/sh/compile
WORKDIR /opt/sh/compile
RUN /root/.cargo/bin/cargo build


FROM ttbb/telegraf:nake

COPY docker-build /opt/telegraf/mate

COPY --from=build /opt/sh/compile/target/debug/telegraf-mate-rust /opt/telegraf/mate/telegraf-mate

WORKDIR /opt/telegraf

CMD ["/usr/bin/dumb-init", "bash", "-vx", "/opt/telegraf/mate/scripts/start.sh"]
