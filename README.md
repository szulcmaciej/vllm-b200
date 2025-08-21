# vLLM B200 Docker Image

A Docker image for running vLLM on NVIDIA B200 GPUs with proper Blackwell (sm_100) support.

## Features

- Based on NVIDIA Triton Server container with custom PyTorch build
- Latest vLLM from source with B200 compatibility
- OpenAI-compatible API server
- Pre-configured for Blackwell GPU support

## Usage

```bash
docker run -it --rm \
  --gpus all \
  --shm-size=20g \
  --network host \
  -v $(pwd):/workspace \
  ghcr.io/your-username/vllm-b200:latest \
  --model /workspace/your-model
```

## Building

The image is automatically built and published to GitHub Container Registry via GitHub Actions.