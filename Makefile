NAME     = baselibrary/kubernetes
REPO     = git@github.com:baselibrary/docker-kubernetes.git
VERSION  = 1.1.2

# input variables
BUILD_DIR              = build
ETCD_BINARIES          = etcd etcdctl
KUBERNETES_BINARIES    = km kubectl

all: build

build: $(BUILD_DIR)
	
release:
	docker push ${NAME}

update:
	docker run --rm -v $$(pwd):/work -w /work buildpack-deps ./update.sh

.PHONY: all clone build 	
$(ETCD_BINARIES):
	@cd $(BUILD_DIR)/etcd && GOOS=linux GOARCH=amd64 ./build
	@cp -pv $(addprefix $(BUILD_DIR)/etcd/bin/, $(ETCD_BINARIES)) .
$(KUBERNETES_BINARIES):
	@cd $(BUILD_DIR)/kubernetes && KUBE_BUILD_PLATFORMS=linux/amd64 KUBERNETES_CONTRIB=mesos  CGO_ENABLED=1 make release-skip-tests
	@cp -pv $(addprefix $(BUILD_DIR)/kubernetes/_output/release-stage/server/linux-amd64/kubernetes/server/bin/, $(KUBERNETES_BINARIES)) .
$(BUILD_DIR): $(ETCD_BINARIES) $(KUBERNETES_BINARIES)
	docker build --rm -t $(NAME):$(VERSION) .
	
	

	

