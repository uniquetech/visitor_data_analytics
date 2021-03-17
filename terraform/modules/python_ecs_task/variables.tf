variable "name" {
  type = string
  description = "The name prefix for kafka related resources."
}

variable "region" {
  type = string
  description = "The AWS region to deploy to."
}

variable "tags" {
  type = map(string)
  description = "The tags to apply to all of the resources."
}

variable "ecs_cluster_arn" {
  type = string
  description = "The ECS cluster to deploy the ECS task to."
}

variable "subnet_ids" {
  type = list(string)
  description = "The subnets IDs for deploying the ECS tasks."
}

variable "security_group_ids" {
  type = list(string)
  description = "The security group IDs associated with the ECS tasks."
}
