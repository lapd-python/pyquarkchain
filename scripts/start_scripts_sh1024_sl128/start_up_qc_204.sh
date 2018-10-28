 #!/bin/bash 
 
 docker pull 10.0.10.124:5000/qc:2.2 
 
 docker run -itd -m 44G --memory-swap -1 --name qc204 --network host -v /root/qc:/root/.quarkchain 10.0.10.124:5000/qc:2.2 slaves.py --cluster_config /root/.quarkchain/config-sh1024-sl128-n3.json
