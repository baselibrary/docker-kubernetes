FROM baselibrary/baseimage:1.0.0
MAINTAINER ShawnMa <qsma@thoughtworks.com>

## Version
ENV KUBERNETES_MAJOR   1.0
ENV KUBERNETES_RELEASE 1.0.7

## Packages
RUN \
  curl -fsSL "https://github.com/coreos/etcd/releases/download/v2.2.2/etcd-v2.2.2-linux-amd64.tar.gz" | tar -zxvf - --strip-components=1 -C /usr/bin/ etcd-v2.2.2-linux-amd64/etcd etcd-v2.2.2-linux-amd64/etcdctl
ADD kubernetes/_output/local/bin/linux/amd64/km      /usr/bin/
ADD kubernetes/_output/local/bin/linux/amd64/kubectl /usr/bin/



## Scripts
ADD docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod a+x            /docker-entrypoint.sh

EXPOSE 4001 7001 2379 2380

VOLUME ["/var/lib/kubernetes"]

ENTRYPOINT ["tini", "--", "/docker-entrypoint.sh"]


