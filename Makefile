args = $(filter-out $@, $(MAKECMDGOALS))

bash:
	docker-compose run yata-app bash

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
	cat ./tmp/token-gcp | docker login -u oauth2accesstoken --password-stdin https://europe-central2-docker.pkg.dev

gcloud.authtoken:
	gcloud auth print-access-token > ./tmp/token-gcp

docker.push:
	docker push europe-central2-docker.pkg.dev/yata-329822/yata/yata

deploy.rollout:
	kubectl rollout restart deployment/yata-pod

kubectl.nginx:
	kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.0.4/deploy/static/provider/cloud/deploy.yaml

kubectl.certmanager:
	kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.0.3/cert-manager.yaml

kubectl.kubeseal:
	kubectl apply -f https://github.com/bitnami-labs/sealed-secrets/releases/download/v0.12.5/controller.yaml

kubectl.apply:
	kubectl apply -f kubernetes/storage/
	kubectl apply -f kubernetes/db/
	kubectl apply -f kubernetes/app/
	kubectl apply -f kubernetes/yata-ingress.yaml
	kubectl apply -f kubernetes/yata-tls-clusterissuer.yaml

kubectl.secrets.create:
	echo "${value}" | kubectl create secret generic ${name} --dry-run=client --from-file=value=/dev/stdin -o yaml | kubeseal | kubectl apply -f -

%:
	@:
