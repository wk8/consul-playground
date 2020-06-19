IMAGE_NAME = consul-playground

# usage:
# make up S=5 C=3
# or
# make up SERVERS=5 CLIENTS=3
.PHONY: up
up: clean image docker-compose.yml
	docker-compose up
	
.PHONY: image
image: Dockerfile
	docker build . -t $(IMAGE_NAME)

docker-compose.yml:
	./generate_compose.rb

.PHONY: clean
clean:
	rm -f docker-compose.yml