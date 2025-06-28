FROM debian:bookworm-slim
SHELL ["bash", "-c"]
WORKDIR /usr/share/squid
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y squid
RUN rm -fr /var/lib/apt/lists/*

COPY custom.conf /etc/squid/conf.d/
RUN squid -k parse
EXPOSE 3128
CMD ["squid", "-N"]
