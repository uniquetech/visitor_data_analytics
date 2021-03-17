resource "aws_ecs_task_definition" "task_definition" {
  family = var.name

  requires_compatibilities = [
    "FARGATE"
  ]

  network_mode = "awsvpc"
  cpu = 4096
  memory = 8192
  execution_role_arn = aws_iam_role.task_role.arn
  task_role_arn = aws_iam_role.task_role.arn

  container_definitions = <<EOF
[
  {
    "name": "${var.name}",
    "image": "${aws_ecr_repository.ecr_repository.repository_url}",
    "command": ["python3", "app/application.py"],
    "environment": [
            {"name": "REGION", "value": "${var.region}"}
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
          "awslogs-group": "${aws_cloudwatch_log_group.task_log_group.name}",
          "awslogs-region": "${var.region}",
          "awslogs-stream-prefix": "${aws_cloudwatch_log_group.task_log_group.name}"
      }
    }
  }
]

EOF

  tags = merge(
  var.tags, {
    "Name" = "${var.name}-task-definition"
  })
}