FROM debian:buster-slim
SHELL ["bash", "-c"]
WORKDIR /usr/share/squid
ENV DEBIAN_FRONTEND noninteractive
RUN apt update && apt-get install -y squid
RUN sed \
  -e 's/^http_access deny all/http_access allow all/g' \
  -e 's/port 443/port 22-33000/g' \
  /etc/squid/squid.conf > /usr/share/squid/squid.conf
COPY options .
RUN rm -fr /var/lib/apt/lists/*
EXPOSE 3128
CMD ["/usr/sbin/squid", "-N", "-f", "/usr/share/squid/squid.conf"]
