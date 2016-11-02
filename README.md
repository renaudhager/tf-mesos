# tf-mesos

## Description
This repo contain terrraform code to build mesos function any AWS DC :
- master
- slaves

All instance provisionning is made by puppet in a masterless mode.

You will need to create a file named : terraform.tfvars to store sensitives variables.
Please see terraform.tfvars.example.

## Limitation

- Currently one stack so any change can bring down the infrastructure.

## TODO

- Create 3 separate stack for instances to avoid down time during change.
