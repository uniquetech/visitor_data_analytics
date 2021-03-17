variable "purpose" {
  type = string
  description = "The purpose for this to exist, usually the project name."
}

variable "environment" {
  type = string
  description = "The environment to deploy to."
}

variable "region" {
  type = string
  description = "The AWS region to deploy to."
}

variable "region_code" {
  type = string
  description = "A two character region code. Such as an ISO 31666 alpha-2 country code."
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