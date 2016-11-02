#
# ROUTE 53
#

resource "aws_route53_record" "mesos_master" {
  zone_id = "${data.terraform_remote_state.core_rs.default_route53_zone}"
  name    = "${var.vdc}-compute-ma0${count.index+1}"
  type    = "A"
  ttl     = "300"
  records = ["${element(aws_instance.mesos_master.*.private_ip, count.index)}"]
  count   = "${length( split( ",", lookup( var.azs, var.region ) ) )}"
}

resource "aws_route53_record" "mesos_slave" {
  zone_id = "${data.terraform_remote_state.core_rs.default_route53_zone}"
  name    = "${var.vdc}-compute-sl0${count.index+1}"
  type    = "A"
  ttl     = "300"
  records = ["${element(aws_instance.mesos_slave.*.private_ip, count.index)}"]
  count   = "${length( split( ",", lookup( var.azs, var.region ) ) )}"
}
