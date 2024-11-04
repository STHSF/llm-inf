sudo docker run -d -it --runtime nvidia --gpus all \
            --name guosen_model \
	    --shm-size 24g \
	    -v /home/liyu/workshop/guoxin:/workshop \
            -p 8082:8082 \
	    -p 8090:8090 \
            3bd4845feb95 \
            /bin/bash
