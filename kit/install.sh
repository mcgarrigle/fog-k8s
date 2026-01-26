# https://www.hostafrica.com/blog/kubernetes/kubernetes-cluster-centos-stream-containerd/


function machine_config {
  echo -e "127.0.01 localhost\n192.168.1.24 tt" > /etc/hosts
}

function add_repos {
  dnf install -y epel-release
  dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
  cp kubernetes.repo /etc/yum.repos.d/
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
  kubeadm init
}

cd kit

machine_config
add_repos
install_containerd
install_kubeadm
