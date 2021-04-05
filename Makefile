
preflight:
	bash ./scripts/infra-preflight.sh

login:
	aws configure

init:
	bash ./scripts/infra-plan.sh

deploy:
	bash ./scripts/infra-deploy.sh

test:
	bash ./scripts/infra-test.sh

destroy:
	bash ./scripts/infra-destroy.sh