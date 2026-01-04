FROM debian:trixie-slim
SHELL ["bash", "-c"]
WORKDIR /usr/share/squid
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
  squid iproute2 \
 && apt-get clean && rm -fr /var/lib/apt/lists/*
COPY acl acl
COPY secure/custom-secure.conf /etc/squid/conf.d/
RUN squid -k parse
EXPOSE 3128
CMD ["squid", "-N"]
