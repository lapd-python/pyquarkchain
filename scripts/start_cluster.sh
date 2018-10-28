#! /bin/bash

echo "start up masters nodes --- "
for ip in `cat ./master1.ip`; do
    echo "start new qc${ip##*.}" 
    ssh root@$ip /root/qc/start_up_qc_${ip##*.}.sh
done


echo -e " \n\n\n start up slaves --- "

for ip in `cat ./slaves.ip`; do
    echo "start new qc${ip##*.}" 
    ssh root@$ip /root/qc/start_up_qc_${ip##*.}.sh
done

echo -e " \n\n\n start up cluster 2 and 3 --- "

for ip in `cat ./cluster2-3.ip`; do
    echo "start new qc${ip##*.}" 
    ssh root@$ip /root/qc/start_up_qc_${ip##*.}.sh
done



