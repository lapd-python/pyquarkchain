#! /bin/bash

# Docker hub
# qc='172.31.3.154:5000/qc:tps'
DOCKER_HUB=$(cat ./docker.hub)
QUARKCHAIN_IMAGE=$(cat ./quarkchain.image)
QC_IMAGE=${DOCKER_HUB}/${QUARKCHAIN_IMAGE}

QC_WORKING_DIR=/root/qc/
mkdir -p start_scripts
BOOTSTRAP_NODE_IP=""
# Master bootstrap nodes
# Root chain
for master_bootstrap in `cat ./master_bootstrap.ip`; do
    # Generate script
    echo "generate master_bootstrap scripts: $master_bootstrap "
    echo -e " #!/bin/bash \n\n  docker pull ${QC_IMAGE} \n \n docker run -itd --name qc${master_bootstrap##*.} --network host -v /root/qc:/root/.quarkchain ${QC_IMAGE} master.py --cluster_config /root/.quarkchain/$1" > ./start_scripts/start_up_qc_${master_bootstrap##*.}.sh
    chmod +x ./start_scripts/start_up_qc_${master_bootstrap##*.}.sh
    BOOTSTRAP_NODE_IP=$master_bootstrap
    # Create working dir
    ssh root@$master_bootstrap "mkdir -p $QC_WORKING_DIR"
    # Copy config file
    scp ./$1 root@$master_bootstrap:/root/qc/
    scp ./start_scripts/start_up_qc_${master_bootstrap##*.}.sh root@$master_bootstrap:/root/qc/
done


# Slave nodes
for slave in `cat ./slaves.ip`; do

    echo "generate $slave scripts"
    # Generate scripts
    echo -e " #!/bin/bash \n \n docker pull ${QC_IMAGE} \n \n docker run -itd  --name qc${slave##*.} --network host -v /root/qc:/root/.quarkchain ${QC_IMAGE} slaves.py --cluster_config /root/.quarkchain/$1" > ./start_scripts/start_up_qc_${slave##*.}.sh
    chmod +x ./start_scripts/start_up_qc_${slave##*.}.sh
    
    # Create working dir
    ssh root@$slave "mkdir -p $QC_WORKING_DIR"
    # Copy config file
    scp ./$1 root@$slave:/root/qc/
    scp ./start_scripts/start_up_qc_${slave##*.}.sh root@$slave:/root/qc/

done

# Other master nodes
for master in `cat ./master2-3.ip`; do
    echo "generate master scripts: $master "
    echo -e " #!/bin/bash \n\n  docker pull ${QC_IMAGE} \n \n docker run -itd --name qc${master##*.} --network host -v /root/qc:/root/.quarkchain ${QC_IMAGE} cluster.py --clean --root_block_interval_sec 60 --minor_block_interval_sec 10 --num_shards 1024 --num_slaves 16 --devp2p_enable --devp2p_bootstrap_host=$BOOTSTRAP_NODE_IP --devp2p_ip=${master}" > ./start_scripts/start_up_qc_${master##*.}.sh
    chmod +x ./start_scripts/start_up_qc_${master##*.}.sh
    
    # Create working dir
    ssh root@$master_bootstrap "mkdir -p $QC_WORKING_DIR"
    # Copy config file
    scp ./$1 root@$master:/root/qc/
    scp ./start_scripts/start_up_qc_${master##*.}.sh root@$master:/root/qc/
done




