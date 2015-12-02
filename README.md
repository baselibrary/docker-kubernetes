## ThoughtWorks Docker Image: kubernetes

[![](http://dockeri.co/image/baselibrary/kubernetes)](https://registry.hub.docker.com/u/baselibrary/kubernetes/)

### Base Docker Image

* `latest`: kubernetes 1.1.2
* `1.1`   : kubernetes 1.1.2

### Installation

    docker pull baselibrary/kubernetes

### Usage

    docker run -it --rm -net=host -e HOST=192.168.99.3 -e K8SM_MESOS_MASTER=zk://10.245.5.2:2181/mesos baselibrary/kubernetes ...
