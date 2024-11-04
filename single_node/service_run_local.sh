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


log_path="/workshop/src/logs/llm"
if [ ! -d "$LOGPATH" ]; then
    echo "Log directory does not exist. Creating directory..."
    mkdir -p "$log_path"
fi
echo "Log path: ${log_path}"


model_path="/workshop/models"
model_name="qwen2-7b"

if [ ! -d "$model_path" ]; then
    echo "Model directory does not exist."
    exit 1
fi
echo "Model path: $model_path"

current_time=$(date +"%Y-%m-%d-%H:%M:%S")
log_file="${log_path}/${model_name}_${current_time}.log"

# 模型启动
export CUDA_VISIBLE_DEVICES=1
python3 -m vllm.entrypoints.openai.api_server \
	--port 8090 \
	--model $model_path \
    	--served-model-name $model_name \
    	--trust-remote-code \
    	--tensor-parallel-size 1  \
    	--gpu-memory-utilization 1.0 \
    	--enforce-eager > ${log_file} 2>&1
