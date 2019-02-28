provider "aws" {
    region = "${var.aws_region}"
}

resource "aws_lb" "demolb" {
  name            = "demo"
  internal        = false
  security_groups = ["${var.www_security_group}"]
  subnets         = ["${var.public_subnets}"]

  enable_deletion_protection = true

  tags {
    Name = "Terraform Demo ALB"  
    Environment = "production"
  }
}

resource "aws_lb_listener" "demolbl" {
  load_balancer_arn = "${aws_lb.demolb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.demo.arn}"
  }

}


# # create target group
resource "aws_alb_target_group" "demo" {
  name     = "demo-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 3
    timeout             = 5
    path                = "/"
    interval            = 10
  }
}

# Target group attachment
resource "aws_autoscaling_attachment" "demoasga" {
  autoscaling_group_name = "${aws_autoscaling_group.demo-asg.id}"
  alb_target_group_arn   = "${aws_alb_target_group.demo.arn}"
}

 resource "aws_lb_target_group_attachment" "demotga" {
   target_group_arn = "${aws_alb_target_group.demo.arn}"
   target_id        = "${aws_instance.demo.id}"
   port             = 80
 }
