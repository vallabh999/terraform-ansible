

resource "aws_instance" "demo" {
  instance_type = "${var.instance_type}"

  ami = "${var.base_ami}"

  key_name = "${var.key_name}"

  count = "${var.num_instances}"

  subnet_id = "${var.subnets[count.index%2]}"

  vpc_security_group_ids = "${var.security_groups}"

  monitoring = true

  lifecycle {
    create_before_destroy = true
  }

  tags {
    "Name"     = "${format("${var.name_prefix}${var.cluster_service}%02d.${var.route53_zone}", count.index + 1)}"
    "Vertical" = "${var.cluster_vertical}"
    "App"      = "${var.cluster_app}"
    "Role"     = "${var.cluster_role}"
    "Cluster"  = "${var.cluster_vertical}-${var.cluster_app}"
  }
}

resource "aws_route53_record" "demo" {
  count   = "${var.num_instances}"
  zone_id = "${var.route53_zone_id}"
  name    = "${format("${var.name_prefix}${var.cluster_service}%02d", count.index + 1)}"
  type    = "A"
  ttl     = "300"
  records = ["${element(aws_instance.demo.*.private_ip, count.index)}"]
}

#terraform {
#  backend "s3" {
#    bucket = "tf-swoo"
#    key    = "production/singapore/services/demo/terraform.tfstate"
#    region = "ap-southeast-1"
#  }
#}
