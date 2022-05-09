init: docker-down docker-build docker-up
up: docker-up
down: docker-down

docker-up:
	docker-compose up -d

docker-down:
	docker-compose down --remove-orphans

docker-pull:
	docker-compose pull

docker-build:
	docker-compose build --pull

show-initial-password:
	docker-compose exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword

deploy:
	ssh -i ${SSH_SECURE_KEY_FILE} deploy@${HOST} -p ${PORT} 'rm -rf jenkins && mkdir jenkins'
	scp -i ${SSH_SECURE_KEY_FILE} -P ${PORT} docker-compose-production.yml deploy@${HOST}:jenkins/docker-compose.yml
	scp -i ${SSH_SECURE_KEY_FILE} -P ${PORT} -r docker deploy@${HOST}:jenkins/docker	# recursively copy dir ./docker
	ssh -i ${SSH_SECURE_KEY_FILE} deploy@${HOST} -p ${PORT} 'cd jenkins && echo "COMPOSE_PROJECT_NAME=jenkins" >> .env'
	ssh -i ${SSH_SECURE_KEY_FILE} deploy@${HOST} -p ${PORT} 'cd jenkins && docker-compose down --remove-orphans'
	ssh -i ${SSH_SECURE_KEY_FILE} deploy@${HOST} -p ${PORT} 'cd jenkins && docker-compose pull'
	ssh -i ${SSH_SECURE_KEY_FILE} deploy@${HOST} -p ${PORT} 'cd jenkins && docker-compose build --pull'
	ssh -i ${SSH_SECURE_KEY_FILE} deploy@${HOST} -p ${PORT} 'cd jenkins && docker-compose up -d'
