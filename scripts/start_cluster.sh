#! /bin/bash

echo "start up master (bootstrap node) nodes --- "
for ip in `cat ./master_bootstrap.ip`; do
    echo "start new qc${ip##*.}" 
    ssh root@$ip /root/qc/start_up_qc_${ip##*.}.sh
done


echo -e " \n\n\n start up slaves --- "

for ip in `cat ./slaves.ip`; do
    echo "start new qc${ip##*.}" 
    ssh root@$ip /root/qc/start_up_qc_${ip##*.}.sh
done

echo -e " \n\n\n start up cluster 2 and 3 --- "

for ip in `cat ./master2-3.ip`; do
    echo "start new qc${ip##*.}" 
    ssh root@$ip /root/qc/start_up_qc_${ip##*.}.sh
done



