resource "aws_cloudwatch_log_group" "task_log_group" {
  name = "${var.name}-log-group"

  tags = merge(
  var.tags, {
    "Name" = "${var.name}-log-group"
  })
}