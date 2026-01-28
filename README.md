Master
```
sudo kit/install.sh patch
sudo kit/install.sh master
kit/install.sh network

kubeadm token create --print-join-command
```

Worker
```
sudo kit/install.sh patch
sudo kit/install.sh worker
sudo kubeadm join 192.168.1.41:6443 --token 6qjbzb.s4iiq9qa3rj7z6kp --discovery-token-ca-cert-hash sha256:65fadf441aef39efad08433a938cca9b259757e5ac23190ed2b5d39ee25ceae7 
```
