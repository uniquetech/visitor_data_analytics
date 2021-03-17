ecr_repository_url="$(terraform output ecr_repository_url)";
aws ecr get-login-password | docker login --username AWS --password-stdin  "$ecr_repository_url";
docker build -t ds-python-ecs-example ..
docker tag ds-python-ecs-example:latest "$ecr_repository_url:latest"
docker push "$ecr_repository_url:latest"