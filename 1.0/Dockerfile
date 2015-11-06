FROM baselibrary/baseimage:1.0.0
MAINTAINER ShawnMa <qsma@thoughtworks.com>

## Version
ENV KUBERNETES_MAJOR   1.0
ENV KUBERNETES_RELEASE 1.0.7

## Packages
RUN \
  curl -fsSL "https://github.com/kubernetes/kubernetes/releases/download/v1.0.7/kubernetes.tar.gz" | tar -zxOf - kubernetes/server/kubernetes-server-linux-amd64.tar.gz | tar -zxvf - --strip-components=3 --exclude=*.* -C /usr/bin/

## Scripts
ADD docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod a+x            /docker-entrypoint.sh

EXPOSE 4001 7001 2379 2380

VOLUME ["/var/lib/kubernetes"]

ENTRYPOINT ["tini", "--", "/docker-entrypoint.sh"]


