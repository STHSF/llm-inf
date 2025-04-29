#!/bin/bash

PROJECT_NAME="qwen3_llm"
PROHECT_PATH="/home/liyu/workshop/LLM/llm-inf"
MODEL_PATH="/mnt/hf_models/Qwen3-8B"
MODEL_NAME="qwen3_8b"
SERVICE_PORT=18092

sudo docker run -d -it --runtime nvidia --gpus all \
        --restart=always \
        --name $PROJECT_NAME \
	--shm-size 24g \
	-v ${PROHECT_PATH}:/workshop/src \
	-v ${MODEL_PATH}:/workshop/models \
	-p ${SERVICE_PORT}:8090 \
        harbor-prd.deepq.tech/algorithm/guosen-model:vllm0.8.4-conda-py3.11-cuda-12.2.0-devel-ubi8 \
        /bin/bash /workshop/src/single_node/service_run_local_functioncall_qwen3.sh ${MODEL_NAME}
