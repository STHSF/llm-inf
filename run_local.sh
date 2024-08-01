# MODEL="/mnt/hf_models/Qwen-7B-Chat"

MODEL="/mnt/hf_models/qwen2/Qwen2-7B-Instruct"

python3 -m vllm.entrypoints.openai.api_server \
	--port 8090 \
	--model $MODEL \
    	--served-model-name "qwen1.5-7b" \
    	--trust-remote-code \
    	--tensor-parallel-size 2  \
    	--gpu-memory-utilization 1.0 \
    	--enforce-eager
