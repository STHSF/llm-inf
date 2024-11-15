#  参考 https://www.xiaoiluo.com/article/vllm-docker-server
# 选用一个基础镜像，就像是选择一个好的起点，这里我们用了 NVIDIA 的 CUDA 镜像，因为我们要做的事情需要大量的计算力。
ARG base=nvcr.io/nvidia/cuda:12.2.0-devel-ubi8

# 从我们之前选好的“起点”开始。
FROM ${base}

# 设定 Conda 版本，就像是告诉厨师，我们今天要用哪种香料进行烹饪。
ARG CONDA_VERSION=py310_23.3.1-0

# 设定 Miniconda 下载地址，就像是选定了一个信得过的菜市场。
ARG MINICONDA_BASE_URL=https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/


# 设置环境变量，这有点像是设定厨房的温度和湿度，让一切都适宜。
ENV DEBIAN_FRONTEND=noninteractive LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8

# 更新软件包，并安装 wget、git 等必要工具，有点像是在厨房里安装各种必要的厨具。
RUN yum -y install httpd; yum clean all; systemctl enable httpd.service

# 根据不同的架构下载相应的 Miniconda 安装包，就像是根据不同的菜谱准备不同的食材。
RUN set -x && \
    UNAME_M="$(uname -m)" && \
    if [ "${UNAME_M}" = "x86_64" ]; then \
    MINICONDA_URL="${MINICONDA_BASE_URL}/Miniconda3-${CONDA_VERSION}-Linux-x86_64.sh"; \
    SHA256SUM="aef279d6baea7f67940f16aad17ebe5f6aac97487c7c03466ff01f4819e5a651"; \
    elif [ "${UNAME_M}" = "s390x" ]; then \
    MINICONDA_URL="${MINICONDA_BASE_URL}/Miniconda3-${CONDA_VERSION}-Linux-s390x.sh"; \
    SHA256SUM="ed4f51afc967e921ff5721151f567a4c43c4288ac93ec2393c6238b8c4891de8"; \
    elif [ "${UNAME_M}" = "aarch64" ]; then \
    MINICONDA_URL="${MINICONDA_BASE_URL}/Miniconda3-${CONDA_VERSION}-Linux-aarch64.sh"; \
    SHA256SUM="6950c7b1f4f65ce9b87ee1a2d684837771ae7b2e6044e0da9e915d1dee6c924c"; \
    elif [ "${UNAME_M}" = "ppc64le" ]; then \
    MINICONDA_URL="${MINICONDA_BASE_URL}/Miniconda3-${CONDA_VERSION}-Linux-ppc64le.sh"; \
    SHA256SUM="b3de538cd542bc4f5a2f2d2a79386288d6e04f0e1459755f3cefe64763e51d16"; \
    fi && \
    wget "${MINICONDA_URL}" -O miniconda.sh -q && \
    echo "${SHA256SUM} miniconda.sh" > shasum && \
    if [ "${CONDA_VERSION}" != "latest" ]; then sha256sum --check --status shasum; fi && \
    mkdir -p /opt && \
    bash miniconda.sh -b -p /opt/conda && \
    rm miniconda.sh shasum && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc && \
    find /opt/conda/ -follow -type f -name '*.a' -delete && \
    find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
    /opt/conda/bin/conda clean -afy

# 设置 Python 的环境变量。
ENV PYTHON_PREFIX=/opt/conda/bin

# 更新 Python、pip 的可执行路径，就像是把这把瑞士军刀挂在腰间，随时准备使用。
RUN update-alternatives --install /usr/bin/python python ${PYTHON_PREFIX}/python 1 && \
    update-alternatives --install /usr/bin/python3 python3 ${PYTHON_PREFIX}/python3 1 && \
    update-alternatives --install /usr/bin/pip pip ${PYTHON_PREFIX}/pip 1 && \
    update-alternatives --install /usr/bin/pip3 pip3 ${PYTHON_PREFIX}/pip3 1

# 创建工作目录，就像是在厨房里清理出一块干净的操作台。
RUN mkdir -p /workspace

# 配置 pip 使用国内源。
RUN pip3 config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

# 安装 transformers、accelerate 等 Python 包，这些就像是我们的厨房里的调料，每种都是做出美味必不可少的。
RUN pip3 install transformers==4.32.0 accelerate tiktoken einops scipy transformers_stream_generator==0.0.4 peft deepspeed fschat

# 特殊的包有时需要单独处理，就像是某些调料需要特别的保存方式。
# RUN pip3 install flash-attention
RUN pip3 install xformers --no-deps

# 安装 vllm 包，并清除 pip 缓存，保持厨房整洁。
RUN pip3 install vllm  && \
    pip3 cache purge

# 设置工作目录，告诉大家：“这里是我的领地！”
WORKDIR /workspace
