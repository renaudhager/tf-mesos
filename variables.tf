#
# AWS Provisioning
#
variable "access_key"          {}
variable "secret_key"          {}
variable "owner"               {}
variable "core_rs_bucket"      {}
variable "core_rs_key"         {}
variable "vdc"                 {}
variable "region"              {}

variable "azs" {
  default = {
    "eu-west-1"    = "a,b,c"
    "eu-central-1" = "a,b"
    "us-east-1"    = "a,b,c"
    "us-west-1"    = "a,c"
    "us-west-2"    = "b,c"
  }
}

#
# INSTANCES SIZES
#

variable "instance_mesos_master" { default = "t2.micro" }
variable "instance_mesos_slave"  { default = "t2.small" }

#
# PUPPET AGENT
#
variable "puppet_agent_version"               { default = "1.7.0-1trusty" }
variable "puppet_env"                         { default = "aws" }
