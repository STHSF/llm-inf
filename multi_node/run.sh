sudo docker run  -it \
    --name llm-ray-head \
    --gpus all \
    -d \
    --network=host \
    --ipc=host \
    -v /mnt/hf_models/Qwen-14B-Chat/:/Qwen-14B-Chat \
    nvcr.io/nvidia/cuda:12.2.0-devel-ubi8 \
    /bin/bash
