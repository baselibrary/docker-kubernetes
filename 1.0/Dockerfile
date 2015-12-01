FROM baselibrary/baseimage:1.0.0
MAINTAINER ShawnMa <qsma@thoughtworks.com>

## Version
ENV KUBERNETES_MAJOR   1.0
ENV KUBERNETES_RELEASE 1.0.7

## Packages
ADD kubernetes/_output/local/bin/linux/amd64/km      /usr/bin/
ADD kubernetes/_output/local/bin/linux/amd64/kubectl /usr/bin/



## Scripts
ADD docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod a+x            /docker-entrypoint.sh

EXPOSE 4001 7001 2379 2380

VOLUME ["/var/lib/kubernetes"]

ENTRYPOINT ["tini", "--", "/docker-entrypoint.sh"]


