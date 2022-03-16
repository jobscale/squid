# Squid

## HTTP Proxy Server

```
{
  docker build . -f Dockerfile -t local/squid
  docker run --rm --name squid  -p 8080:3128 -it local/squid
}

{
  https_proxy=http://127.0.0.1:8080 curl -i https://ifconfig.io
  docker stop squid
}
```
