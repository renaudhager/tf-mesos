#
# Mesos Master
#
resource "aws_instance" "mesos_master" {
  ami             = "${module.ami_ebs.ami_id}"
  instance_type   = "${var.instance_mesos_master}"
  subnet_id       = "${element( split(",", data.terraform_remote_state.core_rs.private_subnet), count.index )}"
  key_name        = "rhager_tf"
  security_groups = [
    "${data.terraform_remote_state.core_rs.sg_common}",
    "${aws_security_group.mesos_master.id}",
    "${aws_security_group.consul.id}"
  ]
  lifecycle {
    ignore_changes = ["security_groups"]
  }
  user_data       = "${element(template_file.mesos_master.*.rendered, count.index)}"
  count           = "${length( split( ",", lookup( var.azs, var.region ) ) )}"

  tags {
    Name          = "${var.vdc}-compute-ma0${count.index+1}"
    Owner         = "${var.owner}"
  }
}

#
# Mesos slave
#
resource "aws_instance" "mesos_slave" {
  ami             = "${module.ami_ebs.ami_id}"
  instance_type   = "${var.instance_mesos_slave}"
  subnet_id       = "${element( split(",", data.terraform_remote_state.core_rs.private_subnet), count.index )}"
  key_name        = "rhager_tf"
  security_groups = [
    "${data.terraform_remote_state.core_rs.sg_common}",
    "${aws_security_group.mesos_slave.id}",
    "${aws_security_group.consul.id}"
  ]
  user_data       = "${element(template_file.mesos_slave.*.rendered, count.index)}"
  count           = "${length( split( ",", lookup( var.azs, var.region ) ) )}"

  tags {
    Name          = "${var.vdc}-compute-sl0${count.index+1}"
    Owner         = "${var.owner}"
  }
}
