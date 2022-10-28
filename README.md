# Squid

## HTTP Proxy Server

```
{
  docker build . -f Dockerfile -t squid:local \
  && docker run --rm --name squid  -p 127.0.0.2:3128:3128 -it squid:local
}

ifconfig() {
  https_proxy=http://127.0.0.2:3128 curl -i https://ifconfig.io/ip
  docker stop squid
}
```
