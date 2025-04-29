#!/bin/bash

# 设置conda的路径
CONDA_PATH="/root/anaconda3/bin"
# 将conda的路径添加到PATH环境变量
export PATH="$CONDA_PATH:$PATH"
# 执行conda的钩子脚本来初始化conda
eval "$(/root/anaconda3/bin/conda shell.bash hook)"
# 检查conda命令是否可用
if ! command -v conda &> /dev/null; then
    echo "Conda is not available."
    exit 1
else
    echo "Conda is initialized and available."
fi

# 设置日志路径
log_path="/workshop/src/logs/llm"
if [ ! -d "$log_path" ]; then
    echo "log directory does not exist. Creating directory..."
    mkdir -p "$log_path"
else
    echo "log path: ${log_path}"
fi

model_path="/workshop/models"
# model_name="qwen3-8b"
model_name=$1

if [ ! -d "$model_path" ]; then
    echo "model directory does not exist."
    exit 1
else
    echo "model path: $model_path"
fi

current_time=$(date +"%Y-%m-%d-%H:%M:%S")
log_file="${log_path}/${model_name}_${current_time}.log"

# 模型启动
export CUDA_VISIBLE_DEVICES=1
python3 -m vllm.entrypoints.openai.api_server \
	--port 8090 \
	--model $model_path \
	--served-model-name $model_name \
	--trust-remote-code \
	--tensor-parallel-size 1 \
	--max_num_seqs 512 \
	--max_model_len 4096 \
	--gpu-memory-utilization 0.9 \
	--enforce-eager \
	--enable-auto-tool-choice \
	--tool-call-parser hermes > ${log_file} 2>&1
