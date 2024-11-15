#!/bin/bash

PROJECT_NAME="qwen_llm_model"
PROHECT_PATH="/home/liyu/workshop/LLM/llm-inf"
MODEL_PATH="/mnt/hf_models/qwen2/Qwen2-7B-Instruct"

sudo docker run -d -it --runtime nvidia --gpus all \
        --restart=always \
        --name $PROJECT_NAME \
	    --shm-size 24g \
	    -v ${PROHECT_PATH}:/workshop/src \
	    -v ${MODEL_PATH}:/workshop/models \
	    -p 18091:8090 \
        harbor-prd.deepq.tech/algorithm/guosen-model:1.0-conda-py3.11-cuda-12.2.0-devel-ubi8 \
        /bin/bash /workshop/src/single_node/service_run_local.sh
