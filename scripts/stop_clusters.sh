#! /bin/bash


for ip in `cat ./master1.ip`; do
    echo "stoping and removing qc${ip##*.}"
    ssh root@$ip "docker stop qc${ip##*.}; docker rm qc${ip##*.}"
done

sleep 30s

for ip in `cat ./slaves.ip`; do
    echo "stoping and removing qc${ip##*.}"
    ssh root@$ip "docker stop qc${ip##*.}; docker rm qc${ip##*.}"
done

for ip in `cat ./cluster2-3.ip`; do
    echo "stoping and removing qc${ip##*.}"
    ssh root@$ip "docker stop qc${ip##*.}; docker rm qc${ip##*.}"
done




