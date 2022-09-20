PORT=8000
DEV_CONTAINER_NAME=d-stunnel-dev:latest
CURRENT_DIR=$(shell pwd)
rsync:
	./build_rsync.sh $(PORT)
	./run_rsync.sh $(PORT)
	echo "Run ./open_fw.sh $(PORT)"
ssh:
	./build_ssh.sh $(PORT)
	./run_ssh.sh $(PORT)
	echo "Run ./open_fw.sh $(PORT)"
http:
	./build_http.sh $(PORT)
	./run_http.sh $(PORT)
	echo "Run ./open_fw.sh $(PORT)"
http-ss:
	docker stop http-stunnel || true
	docker rm http-stunnel || true
	./build_http_ss.sh $(PORT)
	./run_http_ss.sh $(PORT)
	echo "Run ./open_fw.sh $(PORT)"
http-ss-run:
	docker stop http-stunnel || true
	docker rm http-stunnel || true
	./run_http_ss.sh $(PORT)
	echo "Run ./open_fw.sh $(PORT)"
docker-build:
	docker build -t $(DEV_CONTAINER_NAME) -f Dockerfile.ubuntu .
docker-run:
	docker run -v /var/run/docker.sock:/var/run/docker.sock -v $(CURRENT_DIR):/d-stunnel -it $(DEV_CONTAINER_NAME) /bin/bash

