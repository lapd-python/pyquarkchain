 #!/bin/bash 

  docker pull 10.0.10.124:5000/qc:2.2 
 
 docker run -itd --name qc80 --network host -v /root/qc:/root/.quarkchain 10.0.10.124:5000/qc:2.2 cluster.py --clean --root_block_interval_sec 60 --minor_block_interval_sec 10 --num_shards 1024 --num_slaves 8 --devp2p_enable --devp2p_bootstrap_host=10.107.8.60 --devp2p_ip=10.107.8.80
