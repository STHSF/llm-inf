# 参考 https://www.xiaoiluo.com/article/vllm-gpu-ray-multigpu

sudo docker run  \
    --name llm-ray-head \ # 容器名
    --gpus all \ # 使用所有可用的 GPU 设备
    -d          \ # 容器在后台运行（分离模式）
    --network=host \ # 容器使用宿主机的网络配置
    --ipc=host      \ # 容器使用宿主机的 IPC 命名空间
    -v /mnt/hf_models/Qwen-14B-Chat/:/Qwen-14B-Chat \ # 将宿主机的一个目录挂载到容器内
    vllm/vllm-openai:latest  # 运行的 Docker 镜像名和标签
