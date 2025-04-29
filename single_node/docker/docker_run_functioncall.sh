#!/bin/bash

PROJECT_NAME="qwen2.5_functioncall_llm_model"
PROHECT_PATH="/home/liyu/workshop/LLM/llm-inf"
MODEL_PATH="/mnt/hf_models/Qwen2.5-7B-Instruct"
MODEL_NAME="qwen3-8b"
SERVICE_PORT=18089

sudo docker run -d -it --runtime nvidia --gpus all \
        --restart=always \
        --name $PROJECT_NAME \
	--shm-size 24g \
	-v ${PROHECT_PATH}:/workshop/src \
	-v ${MODEL_PATH}:/workshop/models \
	-p ${SERVICE_PORT}:8090 \
        harbor-prd.deepq.tech/algorithm/guosen-model:1.0-conda-py3.11-cuda-12.2.0-devel-ubi8 \
        /bin/bash /workshop/src/single_node/service_run_local_functioncall.sh ${MODEL_NAME}
