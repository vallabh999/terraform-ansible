//
// tags 
// this is going to be used for tagging purpose
//

variable "num_instances" {
  default = 1
}

variable "cluster_app" {
  description = "The name to use for all the cluster resources"
  default = "demo"
}

variable "cluster_vertical" {
  description = "The name to use for all the cluster resources"
  default = "demo"
}

variable "cluster_service" {
  description = "The name to use for all the cluster resources"
  default = "nginx"
}

variable "cluster_role" {
  description = "The name to use for all the cluster resources"
  default = "webserver"
}

variable "name_prefix" {
  default = "pl"
}

variable "instance_type" {
  description = "The type of EC2 Instance"
  default = "t2.micro"
}

variable "base_ami" {
  description = "The type of EC2 Instances to run"
  default = ""
}

variable "key_name" {
  default = "mumbai"
}

variable "security_groups" {
  default = [""]
}

variable "vpc_id" {
  default = ""
}

//
// End of tags
//



variable "aws_region" {
  default = "ap-south-1"
}

//
// route 53 zones 
variable "route53_zone" {
  default = "swoo.tv"
}

variable "route53_zone_id" {
  default = "Z2K7GWE9RR8M9J"
}
// End of route 53
//ID:Z2UGX1ZJ2257GD

// subnets
// we devide the number of instances into two subnet groups 
// so we are configuring two subnets 

variable "subnets" {
  default = ["",""]
}

# for ALB 

variable "public_subnets" {
  default = ["",""]
}

variable "www_security_group" {
  default = [""]
}

variable "availability_zones" {
  default = ["ap-southeast-1a", "ap-southeast-1b"]
}
