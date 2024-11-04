# MODEL="/mnt/hf_models/Qwen-7B-Chat"

# MODEL="/mnt/hf_models/qwen2/Qwen2-7B-Instruct"

MODEL="/mnt/hf_models/Qwen-14B-Chat"

 	# --worker-use-ray \
serve run  vllm.entrypoints.openai.api_server \
	port=8090 \
	model=$MODEL \
    	served-model-name="qwen1.5-7b" \
	trust-remote-code=True\
	tensor-parallel-size=4  \
