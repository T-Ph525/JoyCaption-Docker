# Use the vllm/vllm-openai:v0.7.3 image as the base
FROM vllm/vllm-openai:v0.7.3

# Set environment variables
ENV LANG=C.UTF-8
ENV PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Copy the local repository contents into the container
COPY . /app/

# Install JoyCaption dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Expose the port vLLM will run on
EXPOSE 5000

# Run the model using vLLM with appropriate options
CMD ["vllm", "serve", "fancyfeast/llama-joycaption-alpha-two-hf-llava", "--max-model-len", "4096", "--enable-prefix-caching"]
