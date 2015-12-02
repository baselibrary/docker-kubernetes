#!/bin/bash

#enable job control in script
set -e -m

#####   variables  #####
HOST_IP=${HOST_IP:-0.0.0.0}


apiserver_host=${APISERVER_HOST:-${default_dns_name}}
apiserver_port=${APISERVER_PORT:-18888}
apiserver_proxy_port=${APISERVER_PROXY_PORT:-8888}
apiserver_secure_port=${APISERVER_SECURE_PORT:-6443}



/opt/km apiserver
  --insecure-bind-address=0.0.0.0
  --insecure-port=8080
  --bind-address=${HOST_IP}
  --secure-port=6443
  --cloud-provider=mesos
  --cloud-config=/var/lib/kubernetes/cloud.cfg
  --etcd-servers=${ETCD_SERVERS}
  --service-cluster-ip-range=${SERVICE_CLUSTER_IP_RANGE:-10.10.10.0/24}
  --v=${APISERVER_GLOG_v:-${logv}}


# add command if needed
if [ "${1:0:1}" = '-' ]; then
  set -- kubernetes "$@"
fi

#run command in background
if [ "$1" = 'kubernetes' ]; then
  ##### pre scripts  #####
  echo "========================================================================"
  echo "initialize:"
  echo "========================================================================"
  mkdir -p /var/lib/kubernetes

  # mesos cloud provider configuration
  cat <<EOF >/var/lib/kubernetes/cloud.cfg
  [mesos-cloud]
    mesos-master        = ${mesos_master}
    http-client-timeout = ${K8SM_CLOUD_HTTP_CLIENT_TIMEOUT:-5s}
    state-cache-ttl     = ${K8SM_CLOUD_STATE_CACHE_TTL:-20s}
  EOF

  
  ##### run scripts  #####
  echo "========================================================================"
  echo "startup:"
  echo "========================================================================"
  exec "$@" &

  ##### post scripts #####
  echo "========================================================================"
  echo "configure:"
  echo "========================================================================"
  
  #bring command to foreground
  fg
else
  exec "$@"
fi
