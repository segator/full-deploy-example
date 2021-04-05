variable "region" {
  default = "eu-west-2"
}

variable "cluster_name" {
  default = "test-cluster"
}

variable "instance_type" {
  default = "t3.small"
}

variable "num_workers" {
  default = 1
}

variable "max_workers" {
  default = 3
}