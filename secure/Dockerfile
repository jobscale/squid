FROM debian:bullseye-slim
SHELL ["bash", "-c"]
WORKDIR /usr/share/squid
ENV DEBIAN_FRONTEND noninteractive
RUN apt update && apt-get install -y squid
COPY . .
COPY custom-secure.conf /etc/squid/conf.d/
RUN squid -k parse
RUN rm -fr /var/lib/apt/lists/*
EXPOSE 3128
CMD ["squid", "-N"]
