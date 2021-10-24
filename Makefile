up:
	docker-compose up -d

serve:
	docker-compose up

down:
	docker-compose down

logs:
	docker-compose logs -f

reset:
	make down && make up

psql:
	docker-compose exec yata-db psql -U yatadev yata

build.release:
	docker-compose -f docker-compose.release.yml build release

docker.login:
	gcloud auth print-access-token | docker login -u oauth2accesstoken --password-stdin https://europe-central2-docker.pkg.dev

docker.push:
	docker push europe-central2-docker.pkg.dev/yata-329822/yata/yata

deploy.rollout:
	kubectl rollout restart deployment/yata-pod

kubectl.apply:
	kubectl apply -f kubernetes/
