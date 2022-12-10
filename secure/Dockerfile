FROM debian:bullseye-slim
SHELL ["bash", "-c"]
WORKDIR /usr/share/squid
ENV DEBIAN_FRONTEND noninteractive
RUN apt update && apt-get install -y squid
RUN rm -fr /var/lib/apt/lists/*
COPY acl acl
COPY secure/custom-secure.conf /etc/squid/conf.d/
RUN squid -k parse
EXPOSE 3128
CMD ["squid", "-N"]
