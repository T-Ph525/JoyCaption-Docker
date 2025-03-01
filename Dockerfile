# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set environment variables
ENV LANG=C.UTF-8
ENV PYTHONUNBUFFERED=1

# Install system dependencies
RUN apt-get update && \
    apt-get install -y \
    git \
    curl \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app
# Copy files from local machine to the working directory in the container
COPY . /app/
# Clone the model repository (fancyfeast/llama-joycaption-alpha-two-hf-llava)
RUN git clone https://huggingface.co/fancyfeast/llama-joycaption-alpha-two-hf-llava /app/model

# Install model-specific requirements
RUN pip install -r /app/model/requirements.txt

# Expose the port VLLM will run on
EXPOSE 5000

# Run the model using vllm serve with max-model-len and prefix-caching options
CMD ["vllm", "serve", "fancyfeast/llama-joycaption-alpha-two-hf-llava", "--max-model-len", "4096", "--enable-prefix-caching"]
