FROM nvcr.io/nvidia/tritonserver:25.03-vllm-python-py3

# Set working directory
WORKDIR /opt

# Remove preinstalled vLLM and clean up in one layer to reduce size
RUN pip uninstall -y vllm && \
    rm -rf ~/.cache/pip && \
    rm -rf /usr/local/lib/python*/dist-packages/vllm* && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install latest vLLM from PyPI without dependencies to preserve NVIDIA PyTorch
RUN pip install --no-cache-dir --no-deps vllm && \
    pip install --no-cache-dir llguidance && \
    pip install --no-cache-dir --upgrade --no-deps transformers

# Set environment variables  
ENV PYTHONPATH=/usr/local/lib/python3.10/dist-packages

# Create workspace directory for model mounting
RUN mkdir -p /workspace

# Set default working directory
WORKDIR /workspace

# Expose default port for OpenAI API
EXPOSE 8000

# Default command to start vLLM OpenAI-compatible server
CMD ["python3", "-m", "vllm.entrypoints.openai.api_server", "--host", "0.0.0.0", "--port", "8000"]