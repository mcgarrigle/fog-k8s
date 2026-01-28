#!/bin/bash

PATH=$PATH:../fog

export HOST="?"
export POOL="filesystems"
export IMAGE="rocky10.qcow2"
export OS="rocky9"
export CPUS="4"
export MEMORY="8192"

export ROOT_DEVICE="/dev/sda4"
export ROOT_SIZE="10G"

export NETWORK="network=bridge"
export NETWORK_DEVICE="enp1s0"
export BOOTPROTO="static"
export IP_ADDRESS="?"
export GATEWAY_ADDRESS="192.168.1.254"
export DNS_SERVER="1.1.1.1"

export SSH_PUBLIC_KEY="$(cat ${HOME}/.ssh/id_rsa.pub)"

function _fog {
  echo fog ${HOST} ${IP_ADDRESS}
}

function node {
  HOST="$1"
  IP_ADDRESS="$2"
  fog "${COMMAND}"
}

COMMAND="$1"

node k8s1.mac.wales 192.168.1.41
node k8s2.mac.wales 192.168.1.42
node k8s3.mac.wales 192.168.1.43
