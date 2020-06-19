IMAGE_NAME = consul-playground
CONSUL_BIN ?=

# usage:
# make up S=5 C=3
# or
# make up SERVERS=5 CLIENTS=3
.PHONY: up
up: clean image docker-compose.yml
	docker-compose up --remove-orphans
	
.PHONY: image
image: Dockerfile
	docker build . -t $(IMAGE_NAME) --build-arg CONSUL_BIN=$(CONSUL_BIN)

docker-compose.yml:
	./generate_compose.rb

.PHONY: clean
clean:
	rm -f docker-compose.yml