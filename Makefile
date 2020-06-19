IMAGE_NAME = consul-playground

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