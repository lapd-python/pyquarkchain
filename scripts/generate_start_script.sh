#! /bin/bash


qc='10.0.10.124:5000/qc:2.2'

for master in `cat ./master1.ip`; do
    echo "generate master scriptes: $master "
    echo -e " #!/bin/bash \n\n  docker pull ${qc} \n \n docker run -itd -m 44G --memory-swap -1 --name qc${master##*.} --network host -v /root/qc:/root/.quarkchain ${qc} master.py --cluster_config /root/.quarkchain/$1" > ./start_scripts/start_up_qc_${master##*.}.sh
    chmod +x ./start_scripts/start_up_qc_${master##*.}.sh
    
    scp ./$1 root@$master:/root/qc/
    scp ./start_scripts/start_up_qc_${master##*.}.sh root@$master:/root/qc/
done


for slave in `cat ./slaves.ip`; do

    echo "generate $slave scripts"

    echo -e " #!/bin/bash \n \n docker pull ${qc} \n \n docker run -itd -m 44G --memory-swap -1 --name qc${slave##*.} --network host -v /root/qc:/root/.quarkchain ${qc} slaves.py --cluster_config /root/.quarkchain/$1" > ./start_scripts/start_up_qc_${slave##*.}.sh
    chmod +x ./start_scripts/start_up_qc_${slave##*.}.sh
    
    scp ./$1 root@$slave:/root/qc/
    scp ./start_scripts/start_up_qc_${slave##*.}.sh root@$slave:/root/qc/

done


for master in `cat ./cluster2-3.ip`; do
    echo "generate master scriptes: $master "
    echo -e " #!/bin/bash \n\n  docker pull ${qc} \n \n docker run -itd --name qc${master##*.} --network host -v /root/qc:/root/.quarkchain ${qc} cluster.py --clean --root_block_interval_sec 60 --minor_block_interval_sec 10 --num_shards 1024 --num_slaves 8 --devp2p_enable --devp2p_bootstrap_host=10.107.8.60 --devp2p_ip=${master}" > ./start_scripts/start_up_qc_${master##*.}.sh
    chmod +x ./start_scripts/start_up_qc_${master##*.}.sh
    
    scp ./$1 root@$master:/root/qc/
    scp ./start_scripts/start_up_qc_${master##*.}.sh root@$master:/root/qc/
done




