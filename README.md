# Squid

## TCP Proxy Server

```
main() {
  docker build . -t local/squid
  docker run --rm --name squid  -p 3128:3128 -d local/squid
  echo -n "weit for running 3.."
  for i in {2..0}
  do
    sleep 1.1
    echo -n "$i.."
  done
  echo
  https_proxy=127.0.0.1:3128 curl -i https://ifconfig.io
  docker stop squid
}
main
```
