docker run -d --runtime nvidia --gpus all \
	--name Qwen2-7B-Instruct \
	--shm-size 20g \
	--restart always \
	-v /mnt/hf_models/qwen2/Qwen2-7B-Instruct/:/data/model/Qwen2-7B-Chat \
	-p 8099:8000 \
	vllm/vllm-openai:v0.4.2 \
	--model /data/model/Qwen2-7B-Chat \
	--trust-remote-code \
	--tensor-parallel-size 1 \
	--enforce-eager \
	--enable-auto-tool-choice \
	--tool-call-parser hermes
