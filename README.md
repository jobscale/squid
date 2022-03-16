# Squid

## HTTP Proxy Server

```
main() {
  docker build . -f Dockerfile -t local/squid
  docker run --rm --name squid  -p 8080:3128 -it local/squid
  echo -n "weit for running 3.."
  for i in {2..0}
  do
    sleep 1.2
    echo -n "$i.."
  done
  echo
  https_proxy=http://127.0.0.1:3128 curl -i https://ifconfig.io
  docker stop squid
}
main
```
