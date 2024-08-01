docker run --runtime nvidia --gpus all \
	-v /mnt/hf_models/Qwen-7B-Chat:/data/model/ \
	-p 8090:8000 \
	vllm/vllm-openai \
	--model /data/model/ \
	--trust-remote-code
