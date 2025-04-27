docker run -d --runtime nvidia --gpus all \
	--name Qwen-7B-Chat \
	--shm-size 24g \
	--restart always \
	-v /mnt/hf_models/Qwen-7B-Chat:/data/model/Qwen-7B-Chat \
	-p 8090:8000 \
	vllm/vllm-openai:v0.4.2 \
	--model /data/model/Qwen-7B-Chat \
	--trust-remote-code \
	--tensor-parallel-size 2
