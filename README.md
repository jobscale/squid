# Squid

## HTTP Proxy Server

### build and run

```
{
  docker build . -f Dockerfile -t squid:local \
  && docker run --rm --name squid -p 127.0.0.2:3128:3128 -it squid:local
}
```

### check service

```
{
  https_proxy=http://127.0.0.2:3128 curl -i https://ifconfig.io/ip
  https_proxy=http://127.0.0.2:3128 curl -i https://inet-ip.info/ip
  docker stop squid
}
```

### examples

```
docker run --name squid --restart always -p 3128:3128 -it ghcr.io/jobscale/squid
```
