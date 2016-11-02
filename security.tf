###############################
# Security groups Definitions #
###############################

# Security group for mesos master instance
resource "aws_security_group" "mesos_master" {
  name        = "${var.owner}_mesos_master"
  description = "Allow mesos master traffic to instance"
  vpc_id      = "${data.terraform_remote_state.core_rs.vpc}"

  # Allow zookeeper traffic
  ingress {
    from_port   = 2181
    to_port     = 2181
    protocol    = "tcp"
    cidr_blocks = ["${data.terraform_remote_state.core_rs.vpc_cidr_block}"]
  }

  # Allow mesos traffic
  ingress {
    from_port   = 5050
    to_port     = 5050
    protocol    = "tcp"
    cidr_blocks = ["${data.terraform_remote_state.core_rs.vpc_cidr_block}"]
  }

  # Allow marathon traffic
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["${data.terraform_remote_state.core_rs.vpc_cidr_block}"]
  }

  # Allow all traffic between master
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = -1
    self      = true
  }

  tags {
    Name  = "${var.owner}_mesos_master"
    owner = "${var.owner}"
  }

}

# Security group for mesos slave instance
resource "aws_security_group" "mesos_slave" {
  name        = "${var.owner}_mesos_slave"
  description = "Allow mesos slave traffic to instance"
  vpc_id      = "${data.terraform_remote_state.core_rs.vpc}"

  # Allow tasks traffic on mesos slave
  ingress {
    from_port   = 2000
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["${data.terraform_remote_state.core_rs.vpc_cidr_block}"]
  }

  # Allow tasks traffic on mesos slave
  ingress {
    from_port   = 2000
    to_port     = 65535
    protocol    = "udp"
    cidr_blocks = ["${data.terraform_remote_state.core_rs.vpc_cidr_block}"]
  }

  tags {
    Name  = "${var.owner}_mesos_slave"
    owner = "${var.owner}"
  }

}


# Security group to allow consul trafic
resource "aws_security_group" "consul" {
  name        = "${var.owner}_consul"
  description = "Allow consul traffic to instance"
  vpc_id      = "${data.terraform_remote_state.core_rs.vpc}"

  # Allow consul traffic
  ingress {
    from_port = 8500
    to_port   = 8500
    protocol  = "tcp"
    cidr_blocks    = ["${data.terraform_remote_state.core_rs.vpc_cidr_block}"]
  }
  ingress {
    from_port = 8400
    to_port   = 8400
    protocol  = "tcp"
    cidr_blocks    = ["${data.terraform_remote_state.core_rs.vpc_cidr_block}"]
  }
  ingress {
    from_port = 8400
    to_port   = 8400
    protocol  = "tcp"
    cidr_blocks    = ["${data.terraform_remote_state.core_rs.vpc_cidr_block}"]
  }
  ingress {
    from_port = 8300
    to_port   = 8305
    protocol  = "tcp"
    cidr_blocks    = ["${data.terraform_remote_state.core_rs.vpc_cidr_block}"]
  }

  tags {
    Name  = "${var.owner}_consul"
    owner = "${var.owner}"
  }

}
