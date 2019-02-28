## Creating Launch Configuration
resource "aws_launch_configuration" "demo" {
  image_id             = "${var.base_ami}"
  instance_type        = "t2.micro"
  name_prefix          = "demo-${var.cluster_service}"
  security_groups      = ["${var.security_groups}"]
  key_name             = "${var.key_name}"

  lifecycle {
    create_before_destroy = true
  }
}

## Creating AutoScaling Group
resource "aws_autoscaling_group" "demo-asg" {
  name                 = "${var.cluster_service}-asg"
  launch_configuration = "${aws_launch_configuration.demo.id}"
  availability_zones   = ["${var.availability_zones}"]
  min_size             = 1
  max_size             = 1

  vpc_zone_identifier = ["${var.subnets}"]

  tags = [
    {
      key                 = "Name"
      value               = "${var.name_prefix}${var.cluster_service}-asg"
      propagate_at_launch = true
    },
    {
      key                 = "Vertical"
      value               = "${var.cluster_vertical}"
      propagate_at_launch = true
    },
    {
      key                 = "App"
      value               = "${var.cluster_app}"
      propagate_at_launch = true
    },
    {
      key                 = "Role"
      value               = "${var.cluster_role}"
      propagate_at_launch = true
    },
    {
      key                 = "Cluster"
      value               = "${var.cluster_vertical}-${var.cluster_app}"
      propagate_at_launch = true
    },
  ]
}


