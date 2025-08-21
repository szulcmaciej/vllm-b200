FROM nvcr.io/nvidia/tritonserver:25.03-vllm-python-py3

# Set working directory
WORKDIR /opt

# Remove preinstalled vLLM to avoid conflicts
RUN pip uninstall -y vllm && \
    rm -rf ~/.cache/pip && \
    rm -rf /usr/local/lib/python*/dist-packages/vllm*

# Clone and install latest vLLM from source
RUN git clone https://github.com/vllm-project/vllm.git && \
    cd vllm && \
    pip install -e . --no-deps && \
    pip install llguidance

# Optional: Upgrade transformers for newer models (e.g., Qwen3-30B-A3B)
RUN pip install --upgrade transformers --no-deps

# Set environment variables
ENV PYTHONPATH=/opt/vllm

# Create workspace directory for model mounting
RUN mkdir -p /workspace

# Set default working directory to vllm source
WORKDIR /opt/vllm

# Expose default port for OpenAI API
EXPOSE 8000

# Default command to start vLLM OpenAI-compatible server
CMD ["python3", "-m", "vllm.entrypoints.openai.api_server", "--host", "0.0.0.0", "--port", "8000"]