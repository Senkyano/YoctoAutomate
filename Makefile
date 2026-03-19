help:
	@echo "Available commands:"
	@echo "  make build    - Build all Docker containers"
	@echo "  make up       - Start all services"
	@echo "  make down     - Stop all services"
	@echo "  make restart  - Restart all services"
	@echo "  make logs     - View logs from all services"
	@echo "  make ps       - List running containers"
	@echo "  make clean    - Remove all containers, networks, and volumes"

build:
	docker-compose build

up:
	docker-compose up -d

down:
	docker-compose down

enter:
	docker exec -it yocto_project bash

ps:
	docker-compose ps

clean:
	docker-compose down -v --removes-orphans

fclean: down
	docker-compose system prune -a

logs:
	docker-compose logs -f
