 #!/bin/bash 
 
 docker run -itd --name qc206 --network host -v /root/qc:/root/.quarkchain 10.0.10.124:5000/qc:1.3 cluster.py --cluster_config /root/.quarkchain/config.json
