#!/bin/bash

PATH=$PATH:../fog

export HOST=null
export POOL="filesystems"
export IMAGE="rocky9.qcow2"
export OS="rocky9"
export CPUS="4"
export MEMORY="8192"

export ROOT_DEVICE="/dev/sda5"
export ROOT_SIZE="10G"

export NETWORK="default"
export NETWORK_DEVICE="eth0"
export IP_ADDRESS="192.168.1.24"
export GATEWAY_ADDRESS="192.168.1.254"
export DNS_SERVER="1.1.1.1"

export SSH_PUBLIC_KEY="$(cat ${HOME}/.ssh/id_rsa.pub)"

function _fog {
  echo fog ${HOST} ${IP_ADDRESS}
}

function node {
  HOST="$1"
  IP_ADDRESS="$2"
  fog
}

node k8s1 192.168.1.41
node k8s2 192.168.1.42
node k8s3 192.168.1.43
