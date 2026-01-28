#!/bin/bash

# https://www.hostafrica.com/blog/kubernetes/kubernetes-cluster-centos-stream-containerd/

function machine_config {
  modprobe overlay
  modprobe br_netfilter
  cat <<EOF | sudo tee /etc/modules-load.d/containerd.conf
  overlay
  br_netfilter
EOF

  cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
  net.bridge.bridge-nf-call-iptables = 1
  net.ipv4.ip_forward = 1
  net.bridge.bridge-nf-call-ip6tables = 1
EOF
  sysctl --system
}

function add_repos {
  dnf install -y epel-release
  dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
  cp kubernetes.repo /etc/yum.repos.d/
}

function install_patch {
  dnf update -y
  reboot
}

function install_tooling {
  dnf install -y neovim git
}

function install_containerd {
  dnf install -y containerd
  mkdir -p /etc/containerd
  cp config.toml /etc/containerd/
  systemctl enable --now containerd
}

function install_kubeadm {
  dnf install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
  systemctl enable kubelet.service
}

function install_network {
  kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
}

function install_k8s {
  machine_config
  add_repos
  install_tooling
  install_containerd
  install_kubeadm
}

function install_master {
  install_k8s
  kubeadm init
}

function install_worker {
  install_k8s
}

function install_user {
  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config
}

cd kit

install_$1
