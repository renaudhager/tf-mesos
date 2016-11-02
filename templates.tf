#
# Templates for mesos master
#
resource "template_file" "mesos_master" {
  template               = "${file("cloudinit/default.yml")}"
  count                  = "${length( split( ",", lookup( var.azs, var.region ) ) )}"

  vars {
    puppet_env           = "${var.puppet_env}"
    puppet_agent_version = "${var.puppet_agent_version}"
    hostname             = "${var.vdc}-compute-ma0${count.index+1}"
  }
}

#
# Templates for mesos slave
#
resource "template_file" "mesos_slave" {
  template               = "${file("cloudinit/default.yml")}"
  count                  = "${length( split( ",", lookup( var.azs, var.region ) ) )}"

  vars {
    puppet_env           = "${var.puppet_env}"
    puppet_agent_version = "${var.puppet_agent_version}"
    hostname             = "${var.vdc}-compute-sl0${count.index+1}"
  }
}
