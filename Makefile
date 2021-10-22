up:
	docker-compose up -d

down:
	docker-compose down

logs:
	docker-compose logs -f

reset:
	make down && make up

psql:
	./docker/psql
