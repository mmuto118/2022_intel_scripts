#!/bin/sh
  
sudo docker exec etcd /bin/sh -c "export ETCDCTL_API=3 && /usr/local/bin/etcdctll
 endpoint health"

sudo docker exec etcd /bin/sh -c "export ETCDCTL_API=3 && /usr/local/bin/etcdctll
 endpoint status"

sudo docker exec etcd /bin/sh -c "export ETCDCTL_API=3 && /usr/local/bin/etcdctll
 put foo bar"
