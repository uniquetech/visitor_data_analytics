aws ecs run-task \
--region eu-central-1 \
--cluster dev-data-lake-ecs-cluster  \
--task-definition dev-python-ecs-ppty-data \
--network-configuration '{
  "awsvpcConfiguration": {
    "subnets": [],
    "securityGroups": []
  }
}'