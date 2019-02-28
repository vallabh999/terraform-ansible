variable "availabilityzone1" {
    default = "ap-south-1a"
}

variable "availabilityzone2" {
    default = "ap-south-1b"
}

variable "vpcCIDRBlock" {
    default = "99.99.0.0/16"
}
variable "publicsubnet1" {
    default = "99.99.1.0/24"
}

variable "publicsubnet2" {
    default = "99.99.2.0/24"
}

variable "privatesubnet1" {
    default = "99.99.3.0/24"
}

variable "privatesubnet2" {
    default = "99.99.4.0/24"
}

variable "destinationCIDRBlock" {
    default = "0.0.0.0/0"
}

variable "AWS_REGION" {
  default = "ap-south-1"
}
variable "AMIS" {
  type = "map"
  default = {
    ap-south-1 = "ami-04ea996e7a3e7ad6b"
  }
}

variable "num_instances" {
  default = 1
}

variable "public_key_path" {
  description = "Public key path"
  default = "~/.ssh/id_rsa.pub"
}

variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "/root/.ssh/id_rsa"
}
variable "environment_tag" {
  description = "Environment tag"
  default = "Production"
}
