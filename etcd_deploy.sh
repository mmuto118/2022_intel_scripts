#!/bin/sh
REGISTRY=quay.io/coreos/etcd  #as well as at https://github.com/k3s-io/k3s/releases

TOKEN=QCS-etcd-token
CLUSTER_STATE=new
NAME_1=etcd-node-1
NAME_2=etcd-node-2
NAME_3=etcd-node-3

HOST_1=172.22.0.124 #change IP for the 1st etcd node
HOST_2=172.22.0.125 #change IP for the 2nd etcd node
HOST_3=172.22.0.126 #change IP for the 3rd etcd node

DATA_DIR=/home/ubuntu/etcd/db

THIS_NAME=${NAME_1} #modify the number for each node to be deployed
THIS_IP=${HOST_1}   #modify the number for each node to be deployed


sudo docker run -d \
  --restart=unless-stopped \
  -p 2379:2379 \
  -p 2380:2380 \
  --volume=${DATA_DIR}:/etcd-data \
  --name etcd ${REGISTRY}:${ETCD_VERSION} \
  /usr/local/bin/etcd \
  --data-dir=/etcd-data \
  --name ${THIS_NAME} \
  --initial-advertise-peer-urls http://${THIS_IP}:2380 \
  --listen-peer-urls http://0.0.0.0:2380 \
  --advertise-client-urls http://${THIS_IP}:2379 \
  --listen-client-urls http://0.0.0.0:2379 \
  --initial-cluster ${CLUSTER} \
  --initial-cluster-state ${CLUSTER_STATE} \
  --initial-cluster-token ${TOKEN} \
  --quota-backend-bytes=8589934592 \
  --auto-compaction-retention=3 \
  --snapshot-count=5000
