FROM debian:bookworm-slim
SHELL ["bash", "-c"]
WORKDIR /usr/share/squid
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends apt-transport-https \
  squid curl unzip openssl make g++ libssl-dev libxml2-dev libgnutls28-dev \
 && apt-get clean && rm -fr /var/lib/apt/lists/*
RUN curl -sL -O http://www.squid-cache.org/Versions/v4/squid-4.17.tar.gz
RUN cd /usr/lib && tar xf /usr/share/squid/squid-4.17.tar.gz \
 && mv /usr/lib/squid /usr/lib/squid-4.13 \
 && ln -sfn /usr/lib/squid-4.17 /usr/lib/squid
WORKDIR /usr/lib/squid
RUN ./configure '--build=x86_64-linux-gnu' '--prefix=/usr' \
  '--includedir=${prefix}/include' \
  '--mandir=${prefix}/share/man' \
  '--infodir=${prefix}/share/info' \
  '--sysconfdir=/etc' \
  '--localstatedir=/var' \
  '--disable-option-checking' \
  '--disable-silent-rules' \
  '--libdir=${prefix}/lib/x86_64-linux-gnu' \
  '--runstatedir=/run' \
  '--disable-maintainer-mode' \
  '--disable-dependency-tracking' \
  'BUILDCXXFLAGS=-g -O2 -ffile-prefix-map=/build/squid-Nhk3MN/squid-4.17=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -Wl,-z,relro -Wl,-z,now ' \
  'BUILDCXX=g++' \
  '--with-build-environment=default' \
  '--enable-build-info=Debian linux' \
  '--datadir=/usr/share/squid' \
  '--sysconfdir=/etc/squid' \
  '--libexecdir=/usr/lib/squid' \
  '--mandir=/usr/share/man' \
  '--enable-inline' \
  '--disable-arch-native' \
  '--enable-async-io=8' \
  '--enable-storeio=ufs,aufs,diskd,rock' \
  '--enable-removal-policies=lru,heap' \
  '--enable-delay-pools' \
  '--enable-cache-digests' \
  '--enable-icap-client' \
  '--enable-follow-x-forwarded-for' \
  '--enable-auth-basic=DB,fake,getpwnam,NCSA,NIS,POP3,RADIUS,SMB' \
  '--enable-auth-digest=file' \
  '--enable-auth-negotiate=wrapper' \
  '--enable-auth-ntlm=fake,SMB_LM' \
  '--enable-external-acl-helpers=file_userip,SQL_session,unix_group,wbinfo_group' \
  '--enable-security-cert-validators=fake' \
  '--enable-storeid-rewrite-helpers=file' \
  '--enable-url-rewrite-helpers=fake' \
  '--enable-eui' \
  '--enable-esi' \
  '--enable-icmp' \
  '--enable-zph-qos' \
  '--disable-translation' \
  '--with-swapdir=/var/spool/squid' \
  '--with-logdir=/var/log/squid' \
  '--with-pidfile=/run/squid.pid' \
  '--with-filedescriptors=65536' \
  '--with-large-files' \
  '--with-default-user=proxy' \
  '--enable-linux-netfilter' \
  '--with-gnutls' \
  'build_alias=x86_64-linux-gnu' \
  'CFLAGS=-g -O2 -ffile-prefix-map=/build/squid-Nhk3MN/squid-4.17=. -fstack-protector-strong -Wformat -Werror=format-security -Wall' \
  'LDFLAGS=-Wl,-z,relro -Wl,-z,now ' \
  'CPPFLAGS=-Wdate-time -D_FORTIFY_SOURCE=2' \
  'CXXFLAGS=-g -O2 -ffile-prefix-map=/build/squid-Nhk3MN/squid-4.17=. -fstack-protector-strong -Wformat -Werror=format-security' \
  --enable-ssl-crtd --with-openssl && make && make install
RUN cp /usr/lib/squid/src/squid $(which squid)
RUN openssl dhparam -outform PEM -out /etc/squid/bump_dhparam.pem 2048
RUN mkdir -p /var/lib/squid && rm -rf /var/lib/squid/ssl_db \
 && /usr/lib/squid/security_file_certgen -c -s /var/lib/squid/ssl_db -M 20MB \
 && chown -R proxy:proxy /var/lib/squid

WORKDIR /usr/share/squid
COPY acl acl
COPY intermediate/custom-intermediate.conf /etc/squid/conf.d/
COPY bump.crt /etc/squid/
COPY bump.key /etc/squid/
RUN chown proxy:proxy /etc/squid/bump* && chmod 400 /etc/squid/bump*
RUN squid -v && squid -k parse
EXPOSE 3128
CMD ["squid", "-N"]
