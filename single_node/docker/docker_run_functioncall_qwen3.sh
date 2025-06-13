#!/bin/bash

# 37
PROJECT_NAME="qwen3_llm_20480"
PROHECT_PATH="/home/liyu/workshop/LLM/llm-inf"
MODEL_PATH="/mnt/hf_models/Qwen3-8B"
MODEL_NAME="qwen3_8b"
SERVICE_PORT=18093
TENSOR_PARA_SIZE=1
MAX_MODEL_LEN=20480

# 65
## PROJECT_NAME="qwen3_8b_llm_40960"
## PROHECT_PATH="/home/liyu/workshop/LLM/llm-inf"
## MODEL_PATH="/mnt/192.168.11.37-nfs-data/hf_models/Qwen3-8B"
## MODEL_NAME="qwen3-8b"
## SERVICE_PORT=18083
## TENSOR_PARA_SIZE=2
## AX_MODEL_LEN=400960

sudo docker run -d -it --runtime nvidia --gpus all \
        --restart=always \
        --name $PROJECT_NAME \
	--shm-size 24g \
	-v ${PROHECT_PATH}:/workshop/src \
	-v ${MODEL_PATH}:/workshop/models \
	-p ${SERVICE_PORT}:8090 \
        harbor-prd.deepq.tech/algorithm/guosen-model:vllm0.8.4-conda-py3.11-cuda-12.2.0-devel-ubi8 \
        /bin/bash /workshop/src/single_node/service_run_local_functioncall_qwen3.sh ${MODEL_NAME} ${TENSOR_PARA_SIZE} ${MAX_MODEL_LEN}
