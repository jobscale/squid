FROM debian:bullseye-slim
SHELL ["bash", "-c"]
WORKDIR /usr/share/squid
ENV DEBIAN_FRONTEND noninteractive
RUN apt update && apt-get install -y squid
COPY . .
COPY custom.conf /etc/squid/conf.d/custom.conf
RUN squid -k parse
RUN rm -fr /var/lib/apt/lists/*
EXPOSE 3128
CMD ["squid", "-N"]
